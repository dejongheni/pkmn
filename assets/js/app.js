// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import "react-phoenix"

import SearchBar from "./components/search_bar"
import Radar from "./components/radar"
import LikeBar from "./components/like_bar"
window.Components = {
    SearchBar,
    Radar,
    LikeBar
}