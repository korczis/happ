import React from "react";

interface DemoProps {
    name: string;
}

const Demo: React.FC<DemoProps> = (props: DemoProps) => {
    const name = props.name;
    return (
        <section>
            <h1>Demo - {name}</h1>
        </section>
    );
};

export default Demo;