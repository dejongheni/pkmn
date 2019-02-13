import React, { Component } from 'react'

class LikeBar extends Component {
    state = {
        likes: this.props.likes,
        dislikes: this.props.dislikes
    }
    

    addLike = () => {
        return fetch(this.props.route_likes, {
            method: "PATCH"
        }).then(function(response){
            return response.json();
        }).then((pkmn) => {
            this.setState({
                likes: pkmn.likes,
                dislikes: pkmn.dislikes
            });
        });
    }
    addDislike = () => {
        return fetch(this.props.route_dislikes, {
            method: "PATCH"
        }).then(function(response){
            return response.json();
        }).then((pkmn) => {
            this.setState({
                likes: pkmn.likes,
                dislikes: pkmn.dislikes
            });
        });
    }
    render() {
        return (
            <span>
                <img  src="/images/like.png" alt="Like" onClick={this.addLike} />
                {this.state.likes} | {this.state.dislikes}
                <img  src="/images/dislike.png" alt="Dislike" onClick={this.addDislike}/>
            </span>
        )
    }
}

export default LikeBar