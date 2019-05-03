const ANG = -0.5 + (sqrt(3)/2)im
const SEQ2PHASE = [
    1 1 1
    1 ANG^2 ANG
    1 ANG ANG^2
]
const PHASE2SEQ = (1/3)*[
    1 1 1
    1 ANG ANG^2
    1 ANG^2 ANG
]