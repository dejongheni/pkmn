import React, { Component } from 'react'
import RadarChart from 'react-svg-radar-chart';
import 'react-svg-radar-chart/build/css/index.css'
class Radar extends React.Component {

  render() {
    var max_type= Math.max(...Object.values(this.props.stat_of_type));

    var max_pkmn = Math.max(...Object.values(this.props.stat_of_pkmn));
  
    var max = Math.max(max_type, max_pkmn);
    return (
      <div>
        <RadarChart
            captions={{
              speed: "speed",
              specialdefense: "specialdefense",
              specialattack: "specialattack",
              defense: "defense",
              attack: "attack",
              hp: "hp"
            }}
            data={[
              {
                  data: {
                      speed: this.props.stat_of_type.speed/max,
                      specialdefense: this.props.stat_of_type.specialdefense/max,
                      specialattack: this.props.stat_of_type.specialattack/max,
                      defense: this.props.stat_of_type.defense/max,
                      attack: this.props.stat_of_type.attack/max,
                      hp: this.props.stat_of_type.hp/max
                  },
                  meta: { color: '#58FCEC' }
              },
              {
                  data: {
                      speed: this.props.stat_of_pkmn.speed/max,
                      specialdefense: this.props.stat_of_pkmn.specialdefense/max,
                      specialattack: this.props.stat_of_pkmn.specialattack/max,
                      defense: this.props.stat_of_pkmn.defense/max,
                      attack: this.props.stat_of_pkmn.attack/max,
                      hp: this.props.stat_of_pkmn.hp/max
                  },
                  meta: { color: '#f4ad42' }
              },
            ]}
            size={200}
            options={{
                captions: true,
                dots: true,
            }}
          />
          <p>Stats of pokemon<span style={{background: '#f4ad42'}} className="radar-legend"></span></p>
          <p>Mean stat of type<span style={{background: '#58FCEC'}} className="radar-legend"></span></p>
          
      </div>
    );
  }
}
export default Radar
