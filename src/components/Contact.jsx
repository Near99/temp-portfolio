/* eslint-disable react/prop-types */
import React from "react";
import Header from "../Header.jsx";
import styled from "styled-components";
import {
  AiFillWechat,
  AiFillPhone,
  AiTwotoneMail,
  AiFillGithub,
  AiFillLinkedin,
} from "react-icons/ai";

function Contact({ handleSwitchTheme, handleSwitchLanguage, data }) {
  const { phone, email, wechat, github, linkedin } = data.contact;
  return (
    <>
      <Header
        handleSwitchTheme={handleSwitchTheme}
        handleSwitchLanguage={handleSwitchLanguage}
        data={data}
      />
      <MainSection>
        <ContentSection>
          <OL>
            <ContactInfoList>
              <IconWrapper>
                <AiFillPhone />
              </IconWrapper>
              {phone}
            </ContactInfoList>

            <ContactInfoList>
              <IconWrapper>
                <AiTwotoneMail />
              </IconWrapper>
              {email}
            </ContactInfoList>

            <ContactInfoList>
              <IconWrapper>
                <AiFillWechat />
              </IconWrapper>
              {wechat}
            </ContactInfoList>

            <ContactInfoList>
              <IconWrapper>
                <AiFillGithub />
              </IconWrapper>
              {github}
            </ContactInfoList>

            <ContactInfoList>
              <IconWrapper>
                <AiFillLinkedin />
              </IconWrapper>
              {linkedin}
            </ContactInfoList>
          </OL>
        </ContentSection>
      </MainSection>
    </>
  );
}

export default Contact;

const MainSection = styled.div`
  display: flex;
  flex-flow: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 90vh;
  background: ${(props) => props.theme.bgc};
  color: ${(props) => props.theme.textc};
  transition: all 0.4s ease-in-out;

  @media screen and (max-width: 3300px) {
    height: 90vh;
  }

  @media screen and (max-width: 1965px) {
    height: 90vh;
  }

  @media screen and (max-width: 742px) {
    height: 90vh;
  }
`;

const ContentSection = styled.section`
  width: 60%;
  height: 50vh;
  display: flex;
  justify-content: center;

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

const OL = styled.ol`
  display: flex;
  flex-flow: column;
  justify-content: center;
  align-items: flex-start;
  list-style: none;
  padding: 0;
  width: 30%;

  @media screen and (max-width: 768px) {
    font-size: 0.6rem;
    width: auto;
  }
`;

const ContactInfoList = styled.li`
  display: flex;
  font-size: 1.5rem;
  margin: 1rem 0;
  font-weight: bold;

  @media screen and (max-width: 768px) {
    font-size: 0.8rem;
  }
`;

const IconWrapper = styled.div`
  margin-right: 1.5rem;

  @media screen and (max-width: 768px) {
    font-size: 0.8rem;
  }
`;
