const btnSim = document.getElementById('sim');
const btnNao = document.getElementById('nao');
const btnNext = document.getElementById('btn-next');

const tela1 = document.getElementById('container-inicial');
const tela2 = document.getElementById('mensagem-final');
const tela3 = document.getElementById('tela-parabens');
const bolo = document.getElementById('bolo-box');
const textoAutoestima = document.getElementById('texto-autoestima');

let nextClicks = 0;

// 1. Faz o SIM fugir
btnSim.addEventListener('mouseover', () => {
    const x = Math.random() * (window.innerWidth - btnSim.offsetWidth);
    const y = Math.random() * (window.innerHeight - btnSim.offsetHeight);
    
    btnSim.style.position = 'fixed';
    btnSim.style.left = x + 'px';
    btnSim.style.top = y + 'px';
});

// 2. Clicou no NÃO
btnNao.addEventListener('click', () => {
    tela1.classList.add('hidden');
    tela2.classList.remove('hidden');
});

// 3. Lógica do botão NEXT
btnNext.addEventListener('click', () => {
    nextClicks++;
    
    if (nextClicks === 1) {
        btnNext.innerText = "ERRO NA AUTOESTIMA...";
        btnNext.style.backgroundColor = "black";
        textoAutoestima.innerText = "Aguarde... recalibrando humildade...";
    } else if (nextClicks === 2) {
        btnNext.innerText = "AGORA VAI!";
        btnNext.style.transform = "scale(1.8)";
    } else {
        tela2.classList.add('hidden');
        bolo.classList.add('hidden');
        tela3.classList.remove('hidden');
    }
});