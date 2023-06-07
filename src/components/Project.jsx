/* eslint-disable react/prop-types */
import React from "react";
import Header from "../Header.jsx";
import styled from "styled-components";

function Project({ handleSwitchTheme, handleSwitchLanguage, data }) {
  const projectTitle = data.project.projectTitle;
  const projectInfo = data.project.projectInfo;
  const project = projectInfo.map((project, index) => {
    return (
      <List key={index}>
        <OuterLinkLeft>{project.left}</OuterLinkLeft>
        <OuterLinkRight href={project.link}>{project.right}</OuterLinkRight>
        <P>{project.p}</P>
      </List>
    );
  });
  return (
    <>
      <Header
        handleSwitchTheme={handleSwitchTheme}
        handleSwitchLanguage={handleSwitchLanguage}
        data={data}
      />
      <MainSection>
        <ContentSection>
          <Title>{projectTitle}</Title>
          <Background>
            <UL>{project}</UL>
          </Background>
        </ContentSection>
      </MainSection>
    </>
  );
}

export default Project;

const MainSection = styled.div`
  display: flex;
  flex-flow: column;
  align-items: center;
  width: 100%;
  min-height: 100vh;
  background: ${(props) => props.theme.bgc};
  color: ${(props) => props.theme.textc};
  transition: all 0.4s ease-in-out;

  @media screen and (max-width: 3300px) {
    height: auto;
  }

  @media screen and (max-width: 1965px) {
    height: auto;
  }

  @media screen and (max-width: 742px) {
    height: auto;
  }
`;

const ContentSection = styled.section`
  width: 60%;
  height: 50vh;

  @media screen and (max-width: 3128px) {
    height: auto;
  }

  @media screen and (max-width: 2385px) {
    height: auto;
  }

  @media screen and (max-width: 742px) {
    height: auto;
  }
`;

const Title = styled.h1`
  font-size: 4.5rem;
  margin: 5rem 0 1.5rem 0;

  @media screen and (max-width: 1500px) {
    font-size: 2.5rem;
    margin: 1rem 0;
  }

  @media screen and (max-width: 742px) {
    font-size: 2.5rem;
    margin: 1rem 0;
  }
`;

const Background = styled.article``;

const UL = styled.ul`
  list-style: none;
  position: relative;
  margin-top: 0;
  margin-bottom: 1rem;

  &::before {
    content: " ";
    background: ${(props) => props.theme.timeLine};
    display: inline-block;
    position: absolute;
    left: 0px;
    width: 1px;
    top: 4px;
    height: 100%;
  }
`;

const List = styled.li`
  display: list-item;
  margin: 3rem 0px;
  line-height: 1.5;

  &::before {
    content: " ";
    display: inline-block;
    position: absolute;
    border-radius: 50%;
    background-color: ${(props) => props.theme.bgc};
    border: 2px solid ${(props) => props.theme.circle};
    left: -9px;
    width: 15px;
    height: 15px;
    margin-top: 3px;
  }

  @media screen and (max-width: 742px) {
    display: flex;
    flex-flow: column;
  }
`;

const OuterLinkLeft = styled.a`
  font-weight: 500;
  font-size: 1.5rem;
  color: ${(props) => props.theme.aboutlc};

  @media screen and (max-width: 742px) {
    font-size: 1rem;
  }
`;

const OuterLinkRight = styled.a`
  float: right;
  font-weight: 500;
  font-size: 1.3rem;
  color: ${(props) => props.theme.aboutlc};
  text-decoration: underline;

  @media screen and (max-width: 742px) {
    font-size: 1rem;
  }
`;

const P = styled.p`
  @media screen and (max-width: 742px) {
    font-size: 0.8rem;
  }
`;
