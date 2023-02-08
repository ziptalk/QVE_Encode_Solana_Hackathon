import { Route, BrowserRouter, Routes } from "react-router-dom";

import React, { useState, useEffect } from "react";
import MainPage from "./page/mainPage/index"
import styled from "styled-components";
import Loginpage from "./page/loginPage";
import authService from "./services/auth.service";
import axios from "axios";
import MainTest from "./page/mainPage/component/mainTest";
import Main from "./page/mainPage/component/main";
import MainWalletX from "./page/mainPage/component/mainWalletX";
import LandingPage from "./page/landingPage";
import SwapPage from "./page/swapPage";
import PoolPage from "./page/poolPage";
import StakePage from "./page/stakePage";

const Background = styled.div`
  
`;


function App() {
  //const [currentUser, setCurrentUser] = useState(undefined);

  return (
    <Background className="App">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<LandingPage />}></Route>
          <Route path="/landingPage" element={<LandingPage />}></Route>
          <Route path="/swapPage" element={<SwapPage />}></Route>
          <Route path="/poolPage" element={<PoolPage />}></Route>
          <Route path="/mainPage" element={<MainPage />}></Route>
          <Route path="stakePage" element={<StakePage />}></Route>
        </Routes>
      </BrowserRouter>
    </Background>
  );
}



export default App;
