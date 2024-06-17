import { ROUTES } from "./constant.ts";

describe("register", () => {
  it("should call register API and jump to home page when submit a valid form", () => {
    cy.intercept("POST", /users$/, { fixture: "user.json" }).as(
      "registerRequest",
    );
    cy.visit(ROUTES.REGISTER);

    cy.get('[placeholder="Your Name"]').type("Jarl");
    cy.get('[placeholder="Email"]').type("Jarl@example.com");
    cy.get('[placeholder="Password"]').type("blancherive");

    cy.get('[type="submit"]').click();

    cy.wait("@registerRequest");
    cy.url().should("match", /\/#\/$/);
  });

  it("should display error message when submit the form that username already exist", () => {
    cy.intercept("POST", /users$/, {
      statusCode: 422,
      body: {
        errors: {
          email: ["has already been taken"],
          username: ["has already been taken"],
        },
      },
    }).as("registerRequest");

    cy.visit(ROUTES.REGISTER);

    cy.get('[placeholder="Your Name"]').type("Jarl");
    cy.get('[placeholder="Email"]').type("Jarl@example.com");
    cy.get('[placeholder="Password"]').type("blancherive");

    cy.get('[type="submit"]').click();

    cy.wait("@registerRequest");
    cy.contains("email has already been taken");
    cy.contains("username has already been taken");
  });

  it("should not allow visiting register page when the user is logged in", () => {
    cy.fixture("user.json").then((authResponse) => {
      authResponse.user.username = "Jarl";
      cy.intercept("POST", /users\/login$/, {
        statusCode: 200,
        body: authResponse,
      }).as("loginRequest");
    });

    // click sign in button in home page
    cy.visit(ROUTES.LOGIN);

    cy.get('[type="email"]').type("Jarl@example.com");
    cy.get('[type="password"]').type("blancherive");
    cy.get('[type="submit"]').contains("Sign in").click();

    cy.wait("@loginRequest");
    cy.url().should("match", /#\/$/);

    cy.visit(ROUTES.REGISTER);

    cy.url().should("match", /\/#\/$/);
  });
});

describe("no_article", () => {
  it('should display "No articles are here... yet." when Jarl has no articles', () => {
    cy.fixture("user.json").then((authResponse) => {
      authResponse.user.username = "Jarl";
      cy.intercept("POST", /users\/login$/, {
        statusCode: 200,
        body: authResponse,
      }).as("loginRequest");
    });

    cy.intercept("GET", "/articles?author=Jarl", {
      articles: [],
      articlesCount: 0,
    }).as("getArticles");

    cy.visit(ROUTES.LOGIN);

    cy.get('[type="email"]').type("Jarl@example.com");
    cy.get('[type="password"]').type("blancherive");
    cy.get('[type="submit"]').contains("Sign in").click();

    cy.wait("@loginRequest");
    cy.visit("http://localhost:4137/#/profile/Jarl");

    cy.contains("No articles are here... yet.");
  });
});
