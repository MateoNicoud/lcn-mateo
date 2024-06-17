import { ROUTES } from "./constant.ts";

let name = "Jarl" + Date.now();

describe("register", () => {
  it("should call register API and jump to home page when submit a valid form", () => {
    cy.visit(ROUTES.REGISTER);

    cy.get('[placeholder="Your Name"]').type(name);
    cy.get('[placeholder="Email"]').type(name + "@example.com");
    cy.get('[placeholder="Password"]').type(name);

    cy.intercept("POST", /users$/, {
      statusCode: 200,
      body: {
        user: {
          email: name + "@example.com",
          token: "fake-jwt-token",
          username: name,
          bio: "",
          image: ""
        }
      }
    }).as("registerRequest");

    cy.get('[type="submit"]').click();

    cy.wait("@registerRequest");
    cy.url().should("match", /\/#\/$/);
  });

  it("should display error message when submit the form that username already exist", () => {
    cy.visit(ROUTES.REGISTER);

    cy.get('[placeholder="Your Name"]').type(name);
    cy.get('[placeholder="Email"]').type(name + "@example.com");
    cy.get('[placeholder="Password"]').type(name);

    cy.intercept("POST", /users$/, {
      statusCode: 422,
      body: {
        errors: {
          email: ["has already been taken"],
          username: ["has already been taken"],
        },
      },
    }).as("registerRequest");

    cy.get('[type="submit"]').click();

    cy.wait("@registerRequest");
    cy.contains("email has already been taken");
    cy.contains("username has already been taken");
  });

  it("should not allow visiting register page when the user is logged in", () => {
    cy.intercept("POST", /users\/login$/, {
      statusCode: 200,
      body: {
        user: {
          email: name + "@example.com",
          token: "fake-jwt-token",
          username: name,
          bio: "",
          image: ""
        }
      }
    }).as("loginRequest");

    cy.visit(ROUTES.LOGIN);

    cy.get('[type="email"]').type(name + "@example.com");
    cy.get('[type="password"]').type(name);
    cy.get('[type="submit"]').contains("Sign in").click();

    cy.wait("@loginRequest");
    cy.url().should("match", /#\/$/);

    cy.visit(ROUTES.REGISTER);

    cy.url().should("match", /\/#\/$/);
  });
});

describe("no_article", () => {
  it('should display "No articles are here... yet." when the user has no articles', () => {
    cy.intercept("POST", /users\/login$/, {
      statusCode: 200,
      body: {
        user: {
          email: name + "@example.com",
          token: "fake-jwt-token",
          username: name,
          bio: "",
          image: ""
        }
      }
    }).as("loginRequest");

    cy.intercept("GET", `/articles?author=${name}`, {
      articles: [],
      articlesCount: 0,
    }).as("getArticles");

    cy.visit(ROUTES.LOGIN);

    cy.get('[type="email"]').type(name + "@example.com");
    cy.get('[type="password"]').type(name);
    cy.get('[type="submit"]').contains("Sign in").click();

    cy.wait("@loginRequest");
    cy.visit(`http://localhost:4137/#/profile/${name}`);

    cy.contains("No articles are here... yet.");
  });
});
