import React, { Component } from "react";

export interface MapComponentProps {}

export type MapComponentState = {
    width: number | null,
    height: number | null,
}

// const Demo: React.FC<DemoProps> = (props: DemoProps) => {
export class MapComponent extends Component<MapComponentProps, MapComponentState> {

    constructor(props: MapComponentProps) {
        super(props);

        this.state = {
            width: null,
            height: null,
        }
    }

    public componentDidMount() {
        console.log("componentDidMount()");

        this.setState({
            ...this.state,
            width: window.innerWidth,
            height: window.innerHeight - 56
        });

        window.addEventListener("resize", this.onUpdateWindowDimensions.bind(this));
    }

    private onUpdateWindowDimensions() {
        console.log("onUpdateWindowDimensions()");

        this.setState({
            ...this.state,
            width: window.innerWidth,
            height: window.innerHeight - 56
        });
    }

    render() {
        const style = {
            width: this.state.width,
            height: this.state.height,
            backgroundColor: "blue"
        };

        return (
            <div id="map" style={style}></div>
        );
    }
}

export default MapComponent;