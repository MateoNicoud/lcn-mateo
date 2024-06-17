import { ROUTES } from "./constant.ts";

let name = "Jarl" + Date.now();

describe("register", () => {
  it("should call register API and jump to home page when submit a valid form", () => {
    cy.visit(ROUTES.REGISTER);

    cy.get('[placeholder="Your Name"]').type(name);
    cy.get('[placeholder="Email"]').type(name + "@example.com");
    cy.get('[placeholder="Password"]').type(name);

    cy.get('[type="submit"]').click();

    cy.get(`[aria-label="${name}"]`).should("contain", name);

    cy.visit(`http://localhost:4137/#/profile/${name}`);

    cy.get(`[class="article-preview"]`).should(
      "contain",
      "No articles are here... yet.",
    );
    cy.visit("#/article/create");

    cy.get('[placeholder="Article Title"]').type(name);
    cy.get('[placeholder="What\'s this article about?"]').type(name);
    cy.get('[placeholder="Write your article (in markdown)"]').type(name);
    cy.get('[placeholder="Enter tags"]').type("éducation");
    cy.get('[type="submit"]').contains("Publish Article").click();

    cy.wait(1000);
    cy.visit(`http://localhost:4137/#/profile/${name}`);

    cy.get("a.preview-link h1").should("contain", name);
  });
});
