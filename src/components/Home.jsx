/* eslint-disable react/prop-types */
import React from "react";
import Header from "../Header.jsx";
import styled from "styled-components";
import { HiArrowNarrowRight } from "react-icons/hi";
import { Link } from "react-router-dom";

function Home({ handleSwitchTheme, handleSwitchLanguage, data }) {
  const { nameHeading, briefIntroOne, briefIntroTwo, moreAboutMe } = data.home;
  return (
    <>
      <Header
        handleSwitchTheme={handleSwitchTheme}
        handleSwitchLanguage={handleSwitchLanguage}
        data={data}
      />
      <HomeSection>
        <HeroContainer>
          <TextContainer>
            <NameHeading>{nameHeading}</NameHeading>
          </TextContainer>
          <TextContainer>
            <BriefIntro>{briefIntroOne}</BriefIntro>
          </TextContainer>
          <TextContainer>
            <BriefIntro>{briefIntroTwo}</BriefIntro>
          </TextContainer>
          <GoAboutMe>
            <GoAboutMeLink to="/about">{moreAboutMe}</GoAboutMeLink>
            <GoAboutMeIcon>
              <HiArrowNarrowRight />
            </GoAboutMeIcon>
          </GoAboutMe>
        </HeroContainer>
      </HomeSection>
    </>
  );
}

export default Home;

const HomeSection = styled.section`
  display: flex;
  flex-flow: column;
  justify-content: center;
  align-items: center;
  width: 100%;
  min-height: 90vh;
  background: ${(props) => props.theme.bgc};
  color: ${(props) => props.theme.textc};
  transition: all 0.4s ease-in-out;

  @media screen and (max-width: 2085px) {
    height: auto;
  }
`;

const HeroContainer = styled.div`
  display: flex;
  flex-flow: column;
  width: 60%;
  height: 70%;

  @media screen and (min-width: 2458px) {
    margin-bottom: 10rem;
  }

  @media screen and (min-width: 2085px) {
    margin-bottom: 10rem;
  }
`;

const TextContainer = styled.div`
  width: 100%;
`;

const NameHeading = styled.h1`
  font-size: 7rem;

  @media screen and (max-width: 768px) {
    font-size: 3rem;
  }
`;

const BriefIntro = styled.p`
  width: 70%;
  font-size: 1.2rem;

  @media screen and (max-width: 768px) {
    width: 100%;
    font-size: 0.8rem;
  }
`;

const GoAboutMe = styled.div`
  display: flex;
  justify-content: flex-start;
  margin-top: 3rem;
  font-size: 1.5rem;

  @media screen and (max-width: 768px) {
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 1rem;
    margin: 2rem 0;
    text-align: center;
    font-weight: bold;
  }
`;

const GoAboutMeLink = styled(Link)`
  text-decoration: none;
  color: ${(props) => props.theme.textc};

  &:hover {
    text-decoration: underline;
  }
`;

const GoAboutMeIcon = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  margin-left: 1rem;

  @media screen and (max-width: 768px) {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-left: 2rem;
  }
`;
