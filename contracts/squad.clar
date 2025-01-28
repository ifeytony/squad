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
    (if (map-insert teams {team-id: team-id} {name: name, manager: tx-sender})
      (begin
        (var-set team-id-counter (+ team-id u1))
        (ok team-id))
      (err u0))))

(define-public (add-player (team-id uint) (name (string-ascii 50)))
  (let ((team (map-get? teams {team-id: team-id})))
    (match team
      team-data (if (is-eq (get manager team-data) tx-sender)
                  (let ((player-id (+ team-id u1)))
                    (if (map-insert players {team-id: team-id, player-id: player-id} {name: name})
                      (ok player-id)
                      (err u1)))
                  (err u2))
      (err u3))))

(define-public (schedule-match (team1-id uint) (team2-id uint) (date (string-ascii 20)))
  (let ((match-id (var-get match-id-counter)))
    (if (and
          (is-some (map-get? teams {team-id: team1-id}))
          (is-some (map-get? teams {team-id: team2-id}))
          (map-insert matches {match-id: match-id}
            {team1-id: team1-id, team2-id: team2-id, date: date, result: "Pending"}))
      (begin
        (var-set match-id-counter (+ match-id u1))
        (ok match-id))
      (err u4))))

(define-public (submit-result (match-id uint) (result (string-ascii 20)))
  (let ((match (map-get? matches {match-id: match-id})))
    (match match
      match-data (if (map-set matches {match-id: match-id}
                       (merge match-data {result: result}))
                   (ok true)
                   (err u5))
      (err u6))))