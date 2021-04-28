import React, { Component } from "react";
import L, {Map as LMap} from "leaflet";

import {
    MapContainer,
    TileLayer,
    Marker,
    Popup
} from 'react-leaflet';

import { useWindowDimensions } from "../hooks/window";

export interface LeafletMapProps {}

export type LeafletMapState = {
    map: typeof LMap | null,
    center: number[],
    zoom: number,
    scrollWheelZoom: boolean,

    width: number | null,
    height: number | null,
}

const LeafletMapPlaceholder: React.FC = () => {
    return (
        <div id="map-placeholder"></div>
    );
}

const center = [52.52437, 13.41053];
const zoom = 12;

// const Demo: React.FC<DemoProps> = (props: DemoProps) => {
export class LeafletMap extends Component<LeafletMapProps, LeafletMapState> {

    constructor(props: LeafletMapProps) {
        super(props);

        this.state = {
            map: null,
            center: center,
            zoom: zoom,
            scrollWheelZoom: false,

            width: null,
            height: null,
        }
    }

    public componentDidMount() {
        console.log("componentDidMount()");

        // const map = L.map("leaflet-map", {
        //     minZoom: 2,
        //     maxZoom: 20,
        //     layers: [L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'})],
        //     attributionControl: false,
        // });
        // map.setView(center, zoom)
        // map.fitWorld();
        // map.invalidateSize();

        this.setState({
            ...this.state,
            map: null,
            width: window.innerWidth,
            height: window.innerHeight - 56
        });

        window.addEventListener("resize", this.onUpdateWindowDimensions.bind(this));
    }

    private onMapCreated(map: typeof LMap) {
        console.log("onMapCreated()");
    }

    private onUpdateWindowDimensions() {
        // console.log("onUpdateWindowDimensions()");

        this.setState({
            ...this.state,
            width: window.innerWidth,
            height: window.innerHeight - 56
        });
    }

    render() {
        // const name = this.props.name;

        const style = {
            width: this.state.width,
            height: this.state.height,
            backgroundColor: "blue"
        };

        return (
            // <div id="leaflet-map" style={style} className="map"></div>

            <MapContainer
                id="map"
                center={this.state.center}
                zoom={this.state.zoom}
                scrollWheelZoom={this.state.scrollWheelZoom}
                className="leaflet-map-pane"
                style={{width: "100%"}}
                whenCreated={this.onMapCreated}
                placeholder={<LeafletMapPlaceholder />}
            >
                <TileLayer
                    attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                    url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                />
            </MapContainer>

        );
    }
}

export default LeafletMap;