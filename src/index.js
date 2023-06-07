import React from "react";
import ReactDOM from "react-dom";
import Routes from "./Routes";
import { createGlobalStyle } from "styled-components";

const GlobalStyle = createGlobalStyle`
  html {
    *, ::before, ::after {
      box-sizing: border-box;
      font-family: 'Lato', sans-serif;
    }
  }

  body {
    padding: 0;
    margin: 0;
  }
`;

ReactDOM.render(
  <React.StrictMode>
    <GlobalStyle />
    <Routes />
  </React.StrictMode>,
  document.getElementById("root")
);
