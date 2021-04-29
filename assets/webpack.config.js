const path = require("path");
const WasmPackPlugin = require("@wasm-tool/wasm-pack-plugin");

const glob = require('glob');
const HardSourceWebpackPlugin = require('hard-source-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = (env, options) => {
  const devMode = options.mode !== 'production';
  const wasmEnabled = false;

  return {
    optimization: {
      minimizer: [
        new TerserPlugin({ cache: true, parallel: true, sourceMap: devMode }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },
    entry: {
      'legacy': glob.sync('./vendor/**/*.js').concat(['./js/apps/Legacy.tsx']),
      'spa': glob.sync('./vendor/**/*.js').concat(['./js/apps/Spa.tsx']),
    },
    output: {
      filename: '[name].js',
      path: path.resolve(__dirname, '../priv/static/js'),
      publicPath: '/js/'
    },
    devtool: devMode ? 'eval-cheap-module-source-map' : undefined,
    module: {
      rules: [
        {
          test: /\.(j|t)sx?$/,
          exclude: /node_modules/,
          use: [
            {
                loader: 'babel-loader'
            },
            {
              loader: "ts-loader"
            }
          ]
        },
        {
          test: /\.[s]?css$/,
          use: [
            MiniCssExtractPlugin.loader,
            'css-loader',
            'sass-loader',
          ],
        }
      ]
    },
    resolve: {
      extensions: [".ts", ".tsx", ".js", ".jsx"]
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: '../css/[name].css' }),
      new CopyWebpackPlugin([
        {
          from: 'static/',
          to: '../'
        }]
        .concat(wasmEnabled ? [
          {
            from: 'wasm/pkg/',
            to: '../pkg/'
          },
          {
            from: 'wasm/www/',
            to: '../www/'
          }
        ] : [])
      )

    ]
    .concat(wasmEnabled ? [
      new WasmPackPlugin({
        crateDirectory: path.resolve(__dirname, "wasm"),

        // Check https://rustwasm.github.io/wasm-pack/book/commands/build.html for
        // the available set of arguments.
        //
        // Optional space delimited arguments to appear before the wasm-pack
        // command. Default arguments are `--verbose`.
        args: "--log-level warn",
        // Default arguments are `--typescript --target browser --mode normal`.
        // extraArgs: "--no-typescript",

        // Optional array of absolute paths to directories, changes to which
        // will trigger the build.
        // watchDirectories: [
        //   path.resolve(__dirname, "another-crate/src")
        // ],

        // The same as the `--out-dir` option for `wasm-pack`
        outDir: path.resolve(__dirname, "wasm", "pkg"),

        // The same as the `--out-name` option for `wasm-pack`
        outName: "haap_wasm",

        // If defined, `forceWatch` will force activate/deactivate watch mode for
        // `.rs` files.
        //
        // The default (not set) aligns watch mode for `.rs` files to Webpack's
        // watch mode.
        // forceWatch: true,

        // If defined, `forceMode` will force the compilation mode for `wasm-pack`
        //
        // Possible values are `development` and `production`.
        //
        // the mode `development` makes `wasm-pack` build in `debug` mode.
        // the mode `production` makes `wasm-pack` build in `release` mode.
        // forceMode: "development",

        // Controls plugin output verbosity, either 'info' or 'error'.
        // Defaults to 'info'.
        // pluginLogLevel: 'info'
      })
    ] : [])
    .concat(devMode ? [new HardSourceWebpackPlugin()] : [])
  }
};
