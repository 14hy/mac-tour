const path = require(`path`)
// const UglifyJsPlugin = require(`uglifyjs-webpack-plugin`)
// const BundleAnalyzerPlugin = require(`webpack-bundle-analyzer`).BundleAnalyzerPlugin

module.exports = {
	entry: {
		"main-bundle": [`./src/main.js`],
	},
	output: {
		path: path.resolve(__dirname, `./www`),
		filename: `[name].js`,
	},
	plugins: [
		// new BundleAnalyzerPlugin(),
		// new UglifyJsPlugin({
		// 	uglifyOptions: {
		// 		output: {
		// 			comments: false,
		// 		},
		// 	},
		// }),
	],
	module: {
		rules: [
			{
				test: /\.js$/,
				use: {
					loader: `babel-loader`,
					options: {
						presets: [
							[`@babel/preset-env`, {targets: {ie: `11`}}],
						],
						plugins: [`@babel/plugin-syntax-dynamic-import`],
					},
				},
			},
		],
	},	
	devServer: {
		hot : true,
		contentBase: path.join(__dirname, `/www`),
		watchContentBase: true,
		historyApiFallback: true,
		compress: true,
		host: `0.0.0.0`,
		disableHostCheck: true,
		port: 9000,
	},
	devtool: `inline-source-map`,
}
