use rustler::{Error, ListIterator, NifResult};
use rustler::{NifStruct};

// Basic math functions

#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

#[rustler::nif]
fn div(a: i64, b: i64) -> f32 {
    (a as f32) / (b as f32)
}

#[rustler::nif]
fn mul(a: i64, b: i64) -> i64 {
    a * b
}

#[rustler::nif]
fn sub(a: i64, b: i64) -> i64 {
    a - b
}

// Advanced math functions

#[rustler::nif]
pub fn sum_list(iter: ListIterator) -> NifResult<i64> {
    let res: Result<Vec<i64>, Error> = iter.map(|x| x.decode::<i64>()).collect();

    match res {
        Ok(result) => Ok(result.iter().sum::<i64>()),
        Err(err) => Err(err),
    }
}

// Struct functions

#[derive(Debug, NifStruct)]
#[must_use] // Added to test Issue #152
#[module = "AddStruct"]
pub struct AddStruct {
    lhs: i32,
    rhs: i32,
}

#[rustler::nif]
pub fn struct_echo(add_struct: AddStruct) -> AddStruct {
    add_struct
}

rustler::init!(
    "Elixir.Happ.Native",
    [
        // Basic math functions
        add,
        div,
        mul,
        sub,

        // Advanced math functions
        sum_list,

        // Struct functions
        struct_echo
    ],
    load = load
);

fn load(_: rustler::Env, _: rustler::Term) -> bool {
    true
}