/// CREATE — obj_david

// Animação inicial
sprite_index = spr_alien_idle;
image_speed = 0.12;
image_index = 0;

// Estado do alien
tempo_espera = 0;
estado_alien = 0;

// Movimento
velocidade_x = 4;
velocidade_y = 0;
gravidade = 0.5;
forca_pulo = -10;
no_chao = false;
direcao = 1; // 1 = direita, -1 = esquerda

// Controle das animações
andando = false;
pulando = false;
usando_arma = false;

// Escala de cada animação (ajuste até o alien ficar do mesmo tamanho)
escala_idle = 0.5;
escala_andando = 0.5;
escala_pulo = 0.5;

// Tiro
sprite_tiro = spr_tiro;        // sprite da animação de tiro
velocidade_anim_tiro = 0.25;   // velocidade da animação de tiro
atirando = false;
tempo_atirando = 0;            // frames restantes da animação de tiro
tempo_tiro = 0;                // contador do intervalo entre tiros
cadencia_tiro = 15;            // frames entre um tiro e outro
velocidade_bala = 12;

// Ponto de saída da bala, em pixels a partir do (x, y) do alien
saida_dx = 25;    // para a frente (inverte sozinho quando ele olha para a esquerda)
saida_dy = -40;   // negativo = para cima, positivo = para baixo

// Escala do tiro: calculada pela altura do alien em relação ao idle
var altura_idle = sprite_get_bbox_bottom(spr_alien_idle) - sprite_get_bbox_top(spr_alien_idle) + 1;
var altura_tiro = sprite_get_bbox_bottom(sprite_tiro) - sprite_get_bbox_top(sprite_tiro) + 1;
fator_tiro = 1; // ajuste fino: aumente se ainda diminuir, reduza se aumentar
escala_tiro = escala_idle * (altura_idle / altura_tiro) * fator_tiro;

// Ajuste vertical de cada animação (em pixels)
// Positivo = desce o desenho, negativo = sobe
ajuste_y_idle = 0;
ajuste_y_andando = 0;
ajuste_y_pulo = 0;
ajuste_y_tiro = 0;

// Colisão fixa: não muda quando a animação troca
mask_index = spr_alien_idle;
image_xscale = escala_idle;
image_yscale = escala_idle;

// Vida
vida_max = 3;
vida = vida_max;
invencivel = false;
tempo_invencivel = 0;
duracao_invencivel = 90; // frames sem levar dano depois de ser atingido (1,5 s)

// Morte
morrendo = false;
tempo_morte = 0;

// Perde sempre 1 coração por dano
levar_dano = function() {
    if (invencivel || morrendo) return;

    vida = max(0, vida - 1);
    invencivel = true;
    tempo_invencivel = duracao_invencivel;

    if (vida <= 0) {
        morrendo = true;
        tempo_morte = 60; // 1 segundo antes de reiniciar a fase
    }
};

// Cura 1 coração
curar = function() {
    vida = min(vida_max, vida + 1);
};

// Temporizador da arma
alarm[0] = game_get_speed(gamespeed_fps) * 45;

// Criar o zumbi automaticamente na fase
if (!instance_exists(obj_perigo)) {
    instance_create_layer(x + 300, y, layer, obj_perigo);
}