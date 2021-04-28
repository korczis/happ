import React from "react";
import { HashRouter as Router, Route, Switch } from "react-router-dom";
import { Container } from "react-bootstrap";

import Demo from "../components/Demo"
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
                <Container>
                    <Switch>
                        <Route path="/demo" component={Demo} />
                    </Switch>
                </Container>
            </main>
        </Router>
    );
};

export default Layout;
