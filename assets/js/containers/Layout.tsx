import React from "react";
import { HashRouter as Router, Route, Switch } from "react-router-dom";
import { Container, Row } from "react-bootstrap";

import LeafletMap from "../components/LeafletMap"
import Header from "./Header";

const Layout: React.FC = () => {
    // <ProtectedRoute path="/dashboard" component={Dashboard} />
    // <Route path="/login" component={Login} />
    // <Route path="/loading" component={LoadingPage} />
    // <Route path="/" component={Landing} />

    return (
        <Router>
            <Header />
            <main>
                <Container fluid>
                    <Switch>
                        <Route path="/map">
                            <Row>
                                <LeafletMap/>
                            </Row>
                        </Route>
                    </Switch>
                </Container>
            </main>
        </Router>
    );
};

export default Layout;
