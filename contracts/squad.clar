(define-data-var team-id-counter uint u0)
(define-data-var match-id-counter uint u0)

(define-map teams
  {team-id: uint}
  {name: (string-ascii 50), manager: principal})

(define-map players
  {team-id: uint, player-id: uint}
  {name: (string-ascii 50)})

(define-map matches
  {match-id: uint}
  {team1-id: uint, team2-id: uint, date: (string-ascii 20), result: (string-ascii 20)})

(define-public (register-team (name (string-ascii 50)))
  (let ((team-id (var-get team-id-counter)))
    (begin
      (map-insert teams {team-id: team-id} {name: name, manager: tx-sender})
      (var-set team-id-counter (+ team-id u1))
      (ok team-id))))

(define-public (add-player (team-id uint) (name (string-ascii 50)))
  (let ((team (unwrap-panic (map-get? teams {team-id: team-id}))))
    (if (is-eq (get manager team) tx-sender)
      (let ((player-id (+ team-id u1)))
        (begin
          (map-insert players {team-id: team-id, player-id: player-id} {name: name})
          (ok player-id)))
      (err u0))))

(define-public (schedule-match (team1-id uint) (team2-id uint) (date (string-ascii 20)))
  (let ((match-id (var-get match-id-counter)))
    (begin
      (map-insert matches {match-id: match-id}
        {team1-id: team1-id, team2-id: team2-id, date: date, result: "Pending"})
      (var-set match-id-counter (+ match-id u1))
      (ok match-id))))

(define-public (submit-result (match-id uint) (result (string-ascii 20)))
  (let ((match (unwrap-panic (map-get? matches {match-id: match-id}))))
    (begin
      (map-set matches {match-id: match-id}
        {team1-id: (get team1-id match),
         team2-id: (get team2-id match),
         date: (get date match),
         result: result})
      (ok true))))