// Also see tox

#[allow(dead_code)]
mod util;

extern crate meval;

use meval::{Expr, Context};
use regex::Regex;
use std::borrow::Borrow;

use std::{error::Error, io};

use termion::{
    event::Key,
    input::MouseTerminal,
    raw::IntoRawMode,
    // screen::AlternateScreen,
};

use tui::{
    backend::Backend,
    // backend::TermionBackend,
    layout::{Constraint, Direction, Layout, Rect},
    style::{Color, Modifier, Style},
    text::{Span, Spans, Text},
    widgets::{Block, Borders, List, ListItem, Paragraph},
};

use util::{
    event::Event,
    event::Events,
};

use unicode_width::UnicodeWidthStr;

enum InputMode {
    Normal,
    Editing,
}

// -----

/// App holds the state of the application
struct App {
    /// Current value of the input box
    input: String,

    /// Current input mode
    input_mode: InputMode,

    /// History of recorded messages
    messages: Vec<(String, Result<f64, String>)>,

    /// Math context
    math_context: meval::Context<'static>
}

impl Default for App {
    fn default() -> App {
        let mut context = Context::new();
        context
            .var("a", 3.);

        App {
            input: String::new(),
            input_mode: InputMode::Normal,
            messages: Vec::new(),
            math_context: context
        }
    }
}

// -----

fn handle_input(app: &mut App, events: &mut Events) -> Result<bool, std::sync::mpsc::RecvError> {
    if let Event::Input(input) = events.next()? {
        match app.input_mode {
            InputMode::Normal => match input {
                Key::Char('e') => {
                    app.input_mode = InputMode::Editing;
                    events.disable_exit_key();
                }
                Key::Char('q') => {
                    return Result::Ok(false)
                }
                _ => {}
            },
            InputMode::Editing => match input {
                Key::Char('\n') => {
                    let mut expression: String = app.input.drain(..).collect();
                    expression = expression.trim().to_string();

                    // ^\s*(var)\s+(\w+)\s*[=]\s*(.*)

                    let mut re = Regex::new(r"\s+").unwrap();
                    expression = re.replace_all(&expression[..], " ").to_string();

                    re = Regex::new(r"^\s*(var)\s+(\w+)\s*[=]\s*(.*)").unwrap();
                    expression = match re.captures(&expression) {
                        Some(caps) => {
                            let variable_name = &caps[2];
                            let varable_expresion = &caps[3];

                            match meval::eval_str_with_context(varable_expresion.clone(), &mut app.math_context) {
                                Ok(result) => {
                                    app.math_context
                                        .var(variable_name, result);
                                    variable_name.to_string()
                                }
                                _ => expression
                            }
                        }
                        None => {
                            expression
                        }
                    };

                    // match re.is_match(&mut expression) {
                    //     true => {
                    //         for cap in re.captures_iter(&mut expression) {
                    //             let variable_name = &cap[2];
                    //             let varable_expresion = &cap[3];
                    //
                    //             // println!("FOUND: {} = {}", , variable_name, varable_expresion)
                    //
                    //             match meval::eval_str_with_context(varable_expresion.clone(), &mut app.math_context) {
                    //                 Ok(result) => {
                    //                     app.math_context
                    //                         .var(variable_name, result);
                    //                     expression = variable_name.to_string();
                    //                 }
                    //                 _ => {}
                    //             }
                    //         }
                    //     }
                    //     false => expression
                    // }

                    match meval::eval_str_with_context(expression.clone(), &mut app.math_context) {
                        Ok(result) => {
                            app.messages.push((expression, Ok(result)));
                        }
                        Err(err) => {
                            app.messages.push((expression, Err(err.to_string())));
                        }
                    }


                }
                Key::Char(c) => {
                    app.input.push(c);
                }
                Key::Backspace => {
                    app.input.pop();
                }
                Key::Esc => {
                    app.input_mode = InputMode::Normal;
                    events.enable_exit_key();
                }
                _ => {}
            },
        }
    }

    Result::Ok(true)
}

fn render_help<B>(app: &mut App, frame: &mut tui::Frame<B>, area: Rect)
    where
        B: Backend,
{

    let (msg, style) = match app.input_mode {
        InputMode::Normal => (
            vec![
                Span::raw("Press "),
                Span::styled("q", Style::default().add_modifier(Modifier::BOLD)),
                Span::raw(" to exit, "),
                Span::styled("e", Style::default().add_modifier(Modifier::BOLD)),
                Span::raw(" to start editing."),
            ],
            Style::default().add_modifier(Modifier::RAPID_BLINK),
        ),
        InputMode::Editing => (
            vec![
                Span::raw("Press "),
                Span::styled("Esc", Style::default().add_modifier(Modifier::BOLD)),
                Span::raw(" to stop editing, "),
                Span::styled("Enter", Style::default().add_modifier(Modifier::BOLD)),
                Span::raw(" to record the message"),
            ],
            Style::default(),
        ),
    };

    let mut text = Text::from(Spans::from(msg));
    text.patch_style(style);

    let widget = Paragraph::new(text)
        .style(match app.input_mode {
            InputMode::Normal => Style::default(),
            InputMode::Editing => Style::default() // .fg(Color::Yellow),
        })
        .block(Block::default()
            .borders(Borders::ALL)
            .title("Help"));

    frame.render_widget(widget, area);
}
fn render_input_field<B>(app: &mut App, frame: &mut tui::Frame<B>, area: Rect)
    where
        B: Backend,
{
    let widget = Paragraph::new(app.input.as_ref())
        .style(match app.input_mode {
            InputMode::Normal => Style::default(),
            InputMode::Editing => Style::default().fg(Color::Yellow),
        })
        .block(Block::default()
        .borders(Borders::ALL)
        .title("Expression"));

    frame.render_widget(widget, area);

    match app.input_mode {
        InputMode::Normal =>
        // Hide the cursor. `Frame` does this by default, so we don't need to do anything here
            {}

        InputMode::Editing => {
            // Make the cursor visible and ask tui-rs to put it at the specified coordinates after rendering
            frame.set_cursor(
                // Put cursor past the end of the input text
                area.x + app.input.width() as u16 + 1,
                // Move one line down, from the border to the input line
                area.y + 1,
            )
        }
    }
}

fn render_messages<B>(app: &mut App, frame: &mut tui::Frame<B>, area: Rect)
    where
        B: Backend,
{
    let messages = &app.messages;

    let lines: Vec<ListItem> = messages
        .iter()
        .rev()
        .enumerate()
        .map(|(i, m)| {
            // let content = vec![Spans::from(Span::raw(format!("{}: {}", messages.len() - i, m)))];
            let (expression, result) = m;
            let content = match result {
                Ok(value) => {
                    Spans::from(Span::raw(format!("{}: {} = {}", messages.len() - i, expression, value)))
                }
                Err(err) => {
                    let style = Style::default().fg(Color::Red);
                    Spans::from(
                        Span::styled(format!("{}: {} = {}", messages.len() - i, expression, err), style)

                    )
                }
            };

            ListItem::new(vec![content])
        })
        .collect();

    let widget = List::new(lines)
        .block(Block::default()
        .borders(Borders::ALL)
        .title("Results"));

    frame.render_widget(widget, area);
}

fn setup_layout<B>(frame: &mut tui::Frame<B>) -> Vec<Rect>
    where
        B: Backend,
{
    Layout::default()
        .direction(Direction::Vertical)
        .margin(1)
        .constraints(
            [
                Constraint::Length(3),
                Constraint::Min(1),
                Constraint::Length(3),
            ]
                .as_ref(),
        )
        .split(frame.size())
}

fn main()  -> Result<(), Box<dyn Error>>  {
     // Terminal initialization
    let stdout = io::stdout().into_raw_mode()?;
    let stdout = MouseTerminal::from(stdout);
    let stdout = termion::screen::AlternateScreen::from(stdout);
    let backend = tui::backend::TermionBackend::new(stdout);
    let mut terminal = tui::Terminal::new(backend)?;

    // Setup event handlers
    let mut events = Events::new();

    // Create default app state
    let mut app = App::default();

    // Main loop
    loop {
        // Draw UI
        terminal.draw(|frame| {
            // Specify chunks
            let chunks = setup_layout(frame);

            // Render input field
            render_input_field(&mut app, frame, chunks[0]);

            // Render messages
            render_messages(&mut app, frame, chunks[1]);

            // Render help
            render_help(&mut app, frame, chunks[2]);
        })?;

        // Handle input
        match handle_input(&mut app, &mut events) {
            Ok(false) => break,
            _ => {}
        }
    };

    Ok(())
}
