import React, { Component } from 'react';
import './App.css';

const axios = require('axios');
const serverip = '52.158.237.227';

// TODO can be refactored
function Table(props) {
  const { rows, onClick } = props;

  const handleClick = (event) => {
    onClick(event.currentTarget.dataset.id);
  }

  if (rows.length > 0) {
    let tableRows = [];
    let keys = Object.keys(rows[0]);
    let tableHead = [];
    keys.forEach(key => {
      tableHead.push(<div className="Column">{key}</div>)
    });
    tableRows.push(<div className="tableHead">{tableHead}</div>);
    rows.forEach(row => {
      let tableColumns = [];
      keys.forEach(key => {
        tableColumns.push(<div className="Column">{row[key].toString()}</div>);
      });
      tableRows.push(<div className="Row" data-id={row.id} onClick={handleClick}>{tableColumns}</div>);
    });
    return (
      <div className="table">{tableRows}</div>
    );
  } else {
    return null;
  }
}

class App extends Component {
  constructor(props) {
    super(props);
    this.state = { view: 'home', rows: [] }
    this.initRows(this.state.view);

    this.handleRowClick = this.handleRowClick.bind(this);
  }

  handleRowClick(id) {
    this.getLocks(id);
  }

  // TODO refactor generalize
  getLocks(id) {
    axios.get(`http://${serverip}:4000/locks`, {
      params: {
        id: id
      }
    })
      .then(response => this.setState({ rows: response.data }));
  }

  initRows(table) {
    axios.get(`http://${serverip}:4000/all`, {
      params: {
        table: table
      }
    })
      .then(response => {
        console.log(response.data)
        this.setState({ rows: response.data });
      })
      .catch(error => {
        console.log(error);
      });
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1>Operto Lock Demo</h1>
        </header>
        <div className="body">
          <Table
            rows={this.state.rows}
            onClick={this.handleRowClick}
          />
        </div>
      </div>
    );
  }

}

export default App;
