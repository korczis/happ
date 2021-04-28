import React from "react";

import { useWindowDimensions } from "../hooks/window";

interface DemoProps {
    name: string;
}

const Demo: React.FC<DemoProps> = (props: DemoProps) => {
    const name = props.name;

    const { height, width } = useWindowDimensions();

    return (
        <div id="map" style={{height: height - 56, width: "100%", backgroundColor: "blue"}}>
        </div>
    );
};

export default Demo;