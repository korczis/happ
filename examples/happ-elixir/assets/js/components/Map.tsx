import React, { Component } from "react";

import GoogleMapReact, {
    fitBounds,
    BootstrapURLKeys,
    Coords,
    MapOptions,
    Size
} from 'google-map-react';

export interface MapComponentProps {
    apiKey: string,
    libraries: string | string[]
}

export type MapComponentState = {
    apiKey: string,
    libraries?: string | string[],
    map?: any,
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
            apiKey: props.apiKey,
            size: {
                width: window.innerWidth,
                height: window.innerHeight - 56
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
            key: this.state.apiKey,
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
                    onGoogleApiLoaded={this.onGoogleApiLoaded.bind(this)}
                    onZoomAnimationEnd={this.onZoomAnimationEnd.bind(this)}
                    yesIWantToUseGoogleMapApiInternals={true}
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

    private onGoogleApiLoaded(map: any) {
        console.log("onGoogleApiLoaded()", map);

        this.setState({
            ...this.state,
            map: map.map
        });
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