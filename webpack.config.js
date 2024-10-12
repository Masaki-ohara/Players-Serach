const path = require('path');

module.exports = {
  entry: './src/index.js', // エントリーポイントのパス
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'), // 出力ディレクトリ
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
  resolve: {
    extensions: ['.js'],
  },
  mode: 'production', // モードを指定
};
