import React from "react";
import {
    Container,
    Navbar,
    Nav,
    NavDropdown
    // Form,
    // FormControl,
    // Button
} from "react-bootstrap";

import Link from "../components/Link";

const navBarStyles = {
    backgroundColor: "#fff",
    backgroundImage: "linear-gradient(0deg, #D2D2D2 0%, #97D9E1 100%)",
    boxShadow: "0 0 6px 0 rgba(0, 0, 0, 0.3)"
};

const Header: React.FC = () => {
    return (
        <div>
            <Navbar
                bg="light"
                variant="light"
                expand="lg"
                sticky="top"
                style={navBarStyles}
            >
                <Container>
                    {/* <Navbar.Brand to="/" as={Link}>
                        React+Bootstrap+Typescript
                    </Navbar.Brand> */}
                    <Navbar.Toggle aria-controls="basic-navbar-nav" />
                    <Navbar.Collapse id="basic-navbar-nav">
                        <Nav className="mr-auto">
                            <Nav.Link href="/">Home</Nav.Link>
                            <Link to="/map">Map</Link>
                            <NavDropdown title="Dropdown" id="basic-nav-dropdown">
                                <NavDropdown.Item href="#action/3.1">Action</NavDropdown.Item>
                                <NavDropdown.Item href="/loading">Loading</NavDropdown.Item>
                                <NavDropdown.Divider />
                                <NavDropdown.Item href="#action/3.4">
                                    Separated link
                                </NavDropdown.Item>
                            </NavDropdown>
                        </Nav>
                    </Navbar.Collapse>
                </Container>
            </Navbar>
        </div>
    );
};

export default Header;
