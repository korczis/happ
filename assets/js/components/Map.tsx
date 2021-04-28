import React, { Component } from "react";

import GoogleMapReact, { fitBounds } from 'google-map-react';

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

        const center = { lat: 0, lng: 0 };

        const key = {
            key: 'AIzaSyDoqQWpk1LWnAt2dv8acWr_B7EwMxSjVfE',
            libraries: "places"
        };

        const client = {
            key: 'AIzaSyDoqQWpk1LWnAt2dv8acWr_B7EwMxSjVfE',
            v: '3.28',
            language: 'en',
            libraries: "places",
            region: "PR"
        };

        const options = {
            zoomControl: false,
            gestureHandling: 'cooperative',
            styles: [
                {
                    featureType: "administrative",
                    elementType: "all",
                    stylers: [ {saturation: "-100"} ]
                },
                {
                    featureType: "administrative.neighborhood",
                    stylers: [ {visibility: "off" } ]
                },
                {
                    elementType: "labels.text.stroke",
                    stylers: [ {color: "#242f3e"} ]
                },
                {
                    stylers: [ {color: "#fcfffd"} ]
                }
            ],
        };

        const onDragEnd = (map: any) => {
            console.log("onDragEnd()", map);
        }

        return (
            <div style={style}>
                <GoogleMapReact
                    center={center}
                    heatmapLibrary={false}
                    zoom={3}
                    bootstrapURLKeys={client}
                    options={options}
                    onDragEnd={onDragEnd}
                />;
            </div>
        );
    }
};

export default MapComponent;