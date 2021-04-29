import React, { Component, useRef, useState } from "react";
import * as THREE from 'three'
import FPSStats from "react-fps-stats";

export interface ThreeJsComponentProps {}

export type ThreeJsComponentState = {
    width: number,
    height: number,

    // Three.js
    frameId: any,
    scene: THREE.Scene,
    camera: THREE.PerspectiveCamera,
    renderer: THREE.WebGLRenderer,
    geometry: THREE.BoxGeometry,
    material: THREE.MeshBasicMaterial,
    cube: THREE.Mesh,
}

// See https://codepen.io/WebSeed/pen/MEBoRq
export class ThreeJsComponent extends Component<ThreeJsComponentProps, ThreeJsComponentState> {
    mount = React.createRef<HTMLDivElement>();

    constructor(props: ThreeJsComponentProps) {
        super(props);

        const width = window.innerWidth;
        const height = window.innerHeight - 56;

        const scene = new THREE.Scene()
        const camera = new THREE.PerspectiveCamera(
            75,
            width / height,
            0.1,
            1000
        )

        const renderer = new THREE.WebGLRenderer({ antialias: true })
        const geometry = new THREE.BoxGeometry(1, 1, 1)
        const material = new THREE.MeshBasicMaterial({ color: '#433F81' })
        const cube = new THREE.Mesh(geometry, material)

        camera.position.z = 4
        scene.add(cube)
        renderer.setClearColor('#000000')
        renderer.setSize(width, height)

        this.state = {
            width: window.innerWidth,
            height: window.innerHeight - 56,

            // Three.js
            scene: scene,
            camera: camera,
            frameId: null,
            renderer: renderer,
            geometry: geometry,
            material: material,
            cube: cube
        }

        this.start = this.start.bind(this)
        this.stop = this.stop.bind(this)
        this.animate = this.animate.bind(this)
        this.renderScene = this.renderScene.bind(this)
    }

    public componentDidMount() {
        console.log("componentDidMount()");

        window.addEventListener("resize", this.onUpdateWindowDimensions.bind(this));

        const canvas = document.getElementById('canvas');
        if(canvas) {
            canvas.appendChild(this.state.renderer.domElement);
        }

        this.start()
    }

    componentWillUnmount() {
        this.stop()
        const canvas = document.getElementById('canvas');
        if(canvas) {
            canvas.removeChild(this.state.renderer.domElement);
        }
    }

    start() {
        if (this.state.frameId == null) {
            this.setState({
                ...this.state,
                frameId: requestAnimationFrame(this.animate)
            })
        }
    }

    stop() {
        cancelAnimationFrame(this.state.frameId);
        this.setState({
            ...this.state,
            frameId: null
        })
    }

    animate() {
        this.state.cube.rotation.x += 0.01
        this.state.cube.rotation.y += 0.01

        this.renderScene()
        this.setState({
            ...this.state,
            frameId: window.requestAnimationFrame(this.animate)
        })
    }

    renderScene() {
        this.state.renderer.render(this.state.scene, this.state.camera)
    }

    render() {
        const style = {
            width: this.state.width,
            height: this.state.height,
            backgroundColor: "gray"
        };

        return (
            <div
                id="canvas"
                style={style}
                // ref={(mount) => { this.mount = mount }}
                // ref={(mount) => { this.mount = mount as HTMLDivElement }}
            >
                <FPSStats top={56} left={this.state.width - 76}/>
            </div>
        )
    }

    private onUpdateWindowDimensions() {
        console.log("onUpdateWindowDimensions()");

        const width = window.innerWidth;
        const height = window.innerHeight - 56;

        this.state.camera.aspect = width / height;
        this.state.camera.updateProjectionMatrix();

        this.state.renderer.setSize(width, height);

        this.setState({
            ...this.state,
            width: width,
            height: height,
        });
    }
}

export default ThreeJsComponent;