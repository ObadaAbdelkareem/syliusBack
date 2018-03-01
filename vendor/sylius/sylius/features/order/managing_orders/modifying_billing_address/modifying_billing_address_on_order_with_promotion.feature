@modifying_address
Feature: Modifying a customer's billing address on an order with an applied promotion
    In order to ship an order's bill to a correct place
    As an Administrator
    I want to be able to modify a customer's billing address without changing an order's total

    Background:
        Given the store operates on a single channel in the "United States" named "Web"
        And the store ships everywhere for free
        And the store allows paying with "Cash on Delivery"
        And the store classifies its products as "Suits"
        And the store has a product "Suit" priced at "$400.00"
        And it belongs to "Suits"
        And there is a promotion "Holiday promotion"
        And the promotion gives "$50.00" off if order contains products classified as "Suits"
        And there is a customer "mike@ross.com" that placed an order "#00000001"
        And the customer bought a single "Suit"
        And the customer "Mike Ross" addressed it to "350 5th Ave", "10118" "New York" in the "United States" with identical billing address
        And the customer chose "Free" shipping method with "Cash on Delivery" payment
        And I am logged in as an administrator

    @ui
    Scenario: Modifying a customer's billing address when the applied promotion is no longer valid
        Given the promotion was disabled for the channel "Web"
        When I view the summary of the order "#00000001"
        And I want to modify a customer's billing address of this order
        And I specify their new billing address as "Los Angeles", "Seaside Fwy", "90802", "United States" for "Lucifer Morningstar"
        And I save my changes
        Then I should be notified that it has been successfully edited
        And the order should be billed to "Lucifer Morningstar", "Seaside Fwy", "90802", "Los Angeles", "United States"
        And the order's total should still be "$350.00"
        And the order's promotion total should still be "-$50.00"
