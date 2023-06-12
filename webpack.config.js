const path = require("path")

module.exports = {
  entry: path.resolve(__dirname, "./app/static/app/src/index.js"),
  output: {
    path: path.resolve(__dirname, "./app/static/app/dist"),
    filename: "index.js",
    library: "$",
    libraryTarget: "umd",
  },
  module: {
    // exclude node_modules
    rules: [
      {
        test: /\.(js)$/,
        exclude: /node_modules/,
        use: ["babel-loader"],
      },
    ],
  },
  // pass all js files through Babel
  resolve: {
    extensions: ["*", ".js", ".jsx"],    // <-- added `.jsx` here
  },
  mode: 'development',
  devtool: 'inline-source-map',
}