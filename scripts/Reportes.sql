USE SoundStream;

SELECT 
    u.nombre AS usuario,
    SUM(c.duracion * r.reproducciones) AS minutos_escuchados
FROM usuarios u
INNER JOIN historial_reproducciones r ON u.id = r.usuario_id
INNER JOIN canciones c ON r.cancion_id = c.id
WHERE YEAR(r.fecha) = 2025
GROUP BY u.id, u.nombre
ORDER BY minutos_escuchados DESC
LIMIT 1;

SELECT 
    u.nombre,
    COUNT(*) AS veces_cancelado_recontratar
FROM usuarios u
INNER JOIN historial_suscripciones hs ON u.id = hs.usuario_id
WHERE hs.tipo_evento IN ('cancelacion', 'recontratacion')
  AND YEAR(hs.fecha) = 2025
GROUP BY u.id, u.nombre
HAVING COUNT(*) > 1
ORDER BY veces_cancelado_recontratar DESC
LIMIT 1;

SELECT 
    DATE_FORMAT(p.fecha_pago, '%Y-%m') AS mes,
    SUM(p.monto) AS cantidad
FROM pagos p
WHERE YEAR(p.fecha_pago) = 2025
GROUP BY DATE_FORMAT(p.fecha_pago, '%Y-%m')
ORDER BY mes;
