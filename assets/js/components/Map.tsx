import React, { Component } from "react";

import GoogleMapReact, {
    fitBounds,
    BootstrapURLKeys,
    Coords,
    MapOptions,
    Size
} from 'google-map-react';

export interface MapComponentProps {
    key: string,
    libraries: string | string[]
}

export type MapComponentState = {
    key: string,
    libraries?: string | string[],
    size: Size,
    center: Coords,
    zoom: number,
}

export class MapComponent extends Component<MapComponentProps, MapComponentState> {
    static mapOptions: MapOptions = {
        zoomControl: true,
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
        minZoom: 3
    };

    constructor(props: MapComponentProps) {
        super(props);

        this.state = {
            key: props.key,
            size: {
                width: 1024,
                height: 768,
            },
            center: {
                lat: 49.195061,
                lng: 16.606836
            },
            zoom: 5
        }
    }

    public componentDidMount() {
        console.log("componentDidMount()");

        this.setState({
            ...this.state,
            size: {
                width: window.innerWidth,
                height: window.innerHeight - 56
            }
        });

        window.addEventListener("resize", this.onUpdateWindowDimensions.bind(this));
    }

    render() {
        const style = {
            width: this.state.size.width,
            height: this.state.size.height,
            backgroundColor: "gray"
        };

        const key: BootstrapURLKeys = {
            key: this.state.key,
            libraries: this.state.libraries,
        };

        return (
            <div style={style}>
                <GoogleMapReact
                    center={this.state.center}
                    heatmapLibrary={false}
                    zoom={this.state.zoom}
                    bootstrapURLKeys={key}
                    options={MapComponent.mapOptions}
                    onDragEnd={this.onDragEnd.bind(this)}
                    onZoomAnimationEnd={this.onZoomAnimationEnd.bind(this)}
                />;
            </div>
        );
    }

    private onDragEnd(map: any) {
        console.log("onDragEnd()", map);
        this.setState(
            {
                ...this.state,
                center: {
                    lat: map.center.lat(),
                    lng: map.center.lng()
                }
            },
        )
    }

    private onUpdateWindowDimensions() {
        console.log("onUpdateWindowDimensions()");

        this.setState({
            ...this.state,
            size: {
                width: window.innerWidth,
                height: window.innerHeight - 56
            }
        });
    }

    private onZoomAnimationEnd(zoom: number) {
        console.log("onZoomAnimationEnd()", zoom);

        this.setState({
            ...this.state,
            zoom: zoom
        });
    }
}

export default MapComponent;