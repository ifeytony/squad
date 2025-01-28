# Squad - Decentralized Sports Team Management

Squad is a smart contract designed to help amateur sports teams manage their operations using the Stacks blockchain. It provides tools for registering teams, managing players, scheduling matches, and securely storing match results.

## Features

1. **Team Registration**: Create and register teams with unique IDs and assign a manager.
2. **Player Management**: Add players to teams, ensuring only authorized managers can make changes.
3. **Match Scheduling**: Schedule matches between registered teams, with date tracking.
4. **Result Submission**: Submit and store match results immutably on the blockchain.

## Usage

1. **Register a Team**

   - Function: `register-team`
   - Input: `name (string-utf8 50)`
   - Output: Returns a unique `team-id`.

2. **Add a Player**

   - Function: `add-player`
   - Input: `team-id (uint)`, `name (string-utf8 50)`
   - Output: Adds a player under a team ID.

3. **Schedule a Match**

   - Function: `schedule-match`
   - Input: `team1-id (uint)`, `team2-id (uint)`, `date (string-utf8 20)`
   - Output: Creates a match with a unique match ID.

4. **Submit Match Result**
   - Function: `submit-result`
   - Input: `match-id (uint)`, `result (string-utf8 20)`
   - Output: Updates match results immutably.

## Development

- This contract is written in [Clarity](https://clarity-lang.org/) and tested with [Clarinet](https://github.com/hirosystems/clarinet).
- The code passes `clarinet check` with zero errors or warnings.

## Contributing

- Fork the repository and create a branch named `feature/your-feature-name`.
- Open a pull request and describe the changes made.
