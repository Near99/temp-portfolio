/* eslint-disable react/prop-types */
import React from "react";
import Home from "./components/Home.jsx";

function App({ handleSwitchTheme, handleSwitchLanguage, data }) {
  return (
    <>
      <Home
        handleSwitchTheme={handleSwitchTheme}
        handleSwitchLanguage={handleSwitchLanguage}
        data={data}
      />
    </>
  );
}

export default App;
