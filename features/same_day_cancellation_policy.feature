Feature: Same Day Cancellation Policy
  As a service provider
  In order to provide a fair experience to the customers and not overcharging them when making multiple changes on the same day.
  I want to offer a grace period for for cancellation, during which I'll issue a refund

  Scenario Outline: User subscribes, then cancels within the grace period
    Given I support Independent Payment Strategy
    And   The cancellation grace period is of <grace period>
    And   Today is 3/15/12
    And   I have the following subscriptions:
    # | product names | billing cycle        | status    | #comments                                                | next billing date   |
      | A @ $30       | billed every 1 month | active    | with current permissions and the next billing date is on | 4/15/12              |
    And   I made the following payment: <payment made>
    When  I change to having: <desired state>
    Then  I expect the following action: <action>
    And   I do not expect the following action: <inaction>
    Examples: A customer that have made a payment of $30 the same day of cancellation
      | grace period | payment made                    | desired state | action                    |inaction |
      | 24 hours     | paid $30 for A @ $30 on 3/15/12 |               | refund $30 to A @ $30 now | |
      | 24 hours     | paid $30 for A @ $30 on 3/15/12 |               | disable A @ $30 now       | |

    Examples: A customer that have made a payment just outside of the grace period by 1 second
      | grace period | payment made                    | desired state | action                    | inaction |
      | 24 hours     | paid $30 for A @ $30 on 3/14/12 |               | cancel A @ $30 now        | refund $30 to A @ $30 now |

    Examples: A customer that made a refundable payment greater than the monthly payment
      | grace period | payment made                    | desired state | action                    | inaction |

      | 24 hours     | paid $40 for A @ $30 on 3/15/12 |               | refund $40 to A @ $30 now | |

