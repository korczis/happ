import React from "react";

import {
    MapContainer,
    TileLayer,
    Marker,
    Popup
} from 'react-leaflet';

import { useWindowDimensions } from "../hooks/window";

interface DemoProps {
    name: string;
}

const Demo: React.FC<DemoProps> = (props: DemoProps) => {
    const name = props.name;

    const { height, width } = useWindowDimensions();

    return (
        <div id="map" style={{height: height - 56, width: "100%", backgroundColor: "blue"}}>
            {/*<MapContainer center={[51.505, -0.09]} zoom={13} scrollWheelZoom={false}>*/}
            {/*    <TileLayer*/}
            {/*        attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'*/}
            {/*        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"*/}
            {/*    />*/}
            {/*    <Marker position={[51.505, -0.09]}>*/}
            {/*        <Popup>*/}
            {/*            A pretty CSS3 popup. <br /> Easily customizable.*/}
            {/*        </Popup>*/}
            {/*    </Marker>*/}
            {/*</MapContainer>*/}
        </div>
    );
};

export default Demo;