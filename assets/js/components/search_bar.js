import React, { Component } from 'react'

class SearchBar extends Component {
 state = {
   query: '',
   searchResult: this.props.list_of_pkmns,
   list_of_pkmns: this.props.list_of_pkmns
 }

 handleInputChange = () => {

    this.setState({
        query: this.search.value.toLowerCase(),
        searchResult: this.state.list_of_pkmns.filter((pkmn) => {
                            var id_equals = pkmn.entry_number == this.search.value.toLowerCase();
                            var name_contains = pkmn.pokemon_species.name.includes(this.search.value.toLowerCase());
                            return id_equals || name_contains;
                        })
    })
 }
  Capitalize(str){
    return str.charAt(0).toUpperCase() + str.slice(1);
  }
 render() {
   return (
     <form>
       <input
         placeholder={this.props.placeholder}
         ref={input => this.search = input}
         onChange={this.handleInputChange}
       />
       <ul>{this.state.searchResult.map((pkmn) => {
         return (
            <li key={pkmn.entry_number}>
                <a href={this.props.route + "/" + pkmn.entry_number}>{this.Capitalize(pkmn.pokemon_species.name)}</a>
            </li>
         )
        })}
        </ul>
     </form>
   )
 }
}

export default SearchBar