/// STEP — obj_saida

// O David encostou no portal aberto
if (!trancada && !saindo && destino != noone && instance_exists(obj_david)) {
    var d = obj_david;
    if (rectangle_in_rectangle(d.bbox_left, d.bbox_top, d.bbox_right, d.bbox_bottom,
                               x - larg / 2, y - alt, x + larg / 2, y) != 0) {
        saindo = true;
        var f = instance_create_depth(0, 0, -30000, obj_fade);
        f.destino = destino;
    }
}