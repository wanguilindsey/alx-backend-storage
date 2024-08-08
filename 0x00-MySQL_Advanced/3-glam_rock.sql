-- 3-glam_rock.sql
-- SQL script to list all bands with Glam rock as their main style, ranked by their longevity

-- Query to list bands with Glam rock style and their lifespan
SELECT band_name,
       CASE
           WHEN split IS NOT NULL THEN split - formed
           ELSE 2022 - formed
       END AS lifespan
FROM metal_bands
WHERE style = 'Glam rock'
ORDER BY lifespan DESC;
