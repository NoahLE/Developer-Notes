# Vue CLI Notes

The `vue-cli` is helpful for generating boilerplate projects, but I've had mixed results getting it to merge nicely with pre-existing projects (as of June 2018).

## Installation

Install the Vue CLI

```shell
npm install -g @vue/cli
yarn global add @vue/cli
```

## Commands

`yarn serve` - build the project with HMR and serves it locally
`yarn build` - builds the project for production (use t he yarn `vue.config.js` to edit the results)
`yarn lint` - lint the project
`yarn test:unit` - run the unit tests
`vue inspect` - exports the contents of the webpack config file for debugging and seeing settings

## Setting up a project

Creating the boilerplate files can be done either through the command line or UI.

```shell
# use the CLI to create the boilerplate
# spacebar selects
vue create my-project

# use the UI to create the boilerplate
vue ui

# legacy method
# using templates with things like webpack
# list of projects here: https://github.com/vuejs-templates/webpack
vue init webpack my-project
```

## Sources

- [CLI Documentation](https://github.com/vuejs/vue-cli/)

## vue.config.js file contents

This is a sample config file I used for a project

```javascript
const path = require("path");

module.exports = {
    // where to output the build files
    outputDir: 'derp',

    // where to put the static assets (js / img / font / etc)
    // assetsDir: 'derp-rs',

    // other settings 
    lintOnSave: true,
    productionSourceMap: false,

    // use the full build with in-browser compiler?
    // https://vuejs.org/v2/guide/installation.html#Runtime-Compiler-vs-Runtime-only
    // we will probably start using this when we use templates
    runtimeCompiler: false,

    // tweak internal webpack configuration.
    // see the vue-cli docs for modifying webpack - https://github.com/vuejs/vue-cli/tree/dev/docs/config#chaining-advanced
    // more info about chaining - https://github.com/mozilla-neutrino/webpack-chain#getting-started
    // BREAKS - vue inspect
    chainWebpack: config => {
        config
            // This changes the name of the outputted CSS files
            // .plugin('extract-css')
            // .tap(([options, ...args]) => [
            //     Object.assign({}, options, {
            //         filename: 'css/[name].css'
            //     }),
            //     ...args
            // ])
            .plugin('html-webpack-plugin')
            .tap(([options, ...args]) => [
                Object.assign({}, options, {
                    output: {
                        filename: 'derp-vendor.js'
                    }
                }),
                ...args
            ]);
    },

    configureWebpack: {
        entry: {
            fileone: "./src/main",
            filetwo: "./src/dash"
        },
        output: {
            // path: path.resolve(__dirname, "derpy"),
            filename: "./js/[name].js"
        },
    },

    css: {
        // extract all CSS into a single file for production
        extract: true,

        // enable CSS source maps
        sourceMap: false,

        // options to pass to the CSS leaders
        loaderOptions: {},

        // CSS modules - cool feature but not used at this time
        modules: false
    },

    // use thread-loader for babel & TS in production build
    parallel: require('os').cpus().length > 1,

    // options for progressive web app functionality
    // pwa: {},

    // webpack development server settings
    devServer: {
        open: process.platform === 'darwin',
        disableHostCheck: false,
        host: '0.0.0.0',
        port: 8075,
        https: false,
        // HMR?
        hotOnly: false,
        proxy: null,
        // before: app => {}
    },

    // 3rd party plugin options
    pluginOptions: {

    }
};
```