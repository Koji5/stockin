module.exports = {
  entry: {
    get_suppliers: './app/javascript/get_suppliers.js'
  },
  output: {
    filename: '[name]-bundle.js',
    path: __dirname + '/public/javascripts'
  }
};