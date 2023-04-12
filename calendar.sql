WITH days AS (
    SELECT
        TRUNC(SYSDATE, 'Y') + LEVEL - 1                         AS day,
        TO_CHAR(TRUNC(SYSDATE, 'Y') + LEVEL - 1, 'IYIW')        AS week,
        TO_CHAR(TRUNC(SYSDATE, 'Y') + LEVEL - 1, 'MM/YYYY')     AS month
    FROM DUAL
    CONNECT BY LEVEL <= ADD_MONTHS(TRUNC(SYSDATE, 'Y'), 12) - TRUNC(SYSDATE, 'Y')
)
SELECT
    d.month,
    d.week,
    MAX(DECODE(TO_CHAR(d.day, 'DY'), 'MON', TO_NUMBER(TO_CHAR(d.day, 'FMDD')))) AS mon,
    MAX(DECODE(TO_CHAR(d.day, 'DY'), 'TUE', TO_NUMBER(TO_CHAR(d.day, 'FMDD')))) AS tue,
    MAX(DECODE(TO_CHAR(d.day, 'DY'), 'WED', TO_NUMBER(TO_CHAR(d.day, 'FMDD')))) AS wed,
    MAX(DECODE(TO_CHAR(d.day, 'DY'), 'THU', TO_NUMBER(TO_CHAR(d.day, 'FMDD')))) AS thu,
    MAX(DECODE(TO_CHAR(d.day, 'DY'), 'FRI', TO_NUMBER(TO_CHAR(d.day, 'FMDD')))) AS fri,
    MAX(DECODE(TO_CHAR(d.day, 'DY'), 'SAT', TO_NUMBER(TO_CHAR(d.day, 'FMDD')))) AS sat,
    MAX(DECODE(TO_CHAR(d.day, 'DY'), 'SUN', TO_NUMBER(TO_CHAR(d.day, 'FMDD')))) AS sun
FROM days d
GROUP BY d.month, d.week
ORDER BY 1, 2;
