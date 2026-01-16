using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TagPerson.Domain.ValueObjects
{

    public enum TipoAcao
    {
        Ataque,
        Movimento,
        UsarTecnica,
        UsarHabilidade,
        ConjurarMagia,
        DefesaTotal,
        PassarTurno
    }

    public class Iniciativa
    {
        public int Valor { get; init; }
    }

    public static class IniciativaService
    {
        public static int Calcular(Atributos atributos, int rolagem)
        {
            return atributos.Agilidade + atributos.Percepcao + rolagem;
        }
    }
    public class EstadoTurno
    {
        public bool AcaoExecutada { get; set; }
        public bool MovimentoExecutado { get; set; }
        public EstadoTurno Turno { get; } = new();
    }

    public static class TurnoService
    {
        public static void ValidarAcao(Personagem personagem, TipoAcao acao)
        {
            var efeitos = personagem.Condicoes.Select(c => CondicoesTabela.Obter(c.Tipo));

            if (efeitos.Any(e => e.ImpedeMovimento)
                && acao == TipoAcao.Movimento)
                throw new Exception("Movimento impedido.");

            if (efeitos.Any(e => e.ImpedeAtaque)
                && acao == TipoAcao.Ataque)
                throw new Exception("Ataque impedido.");

            if (personagem.Turno.AcaoExecutada
                && acao != TipoAcao.Movimento)
                throw new Exception("Ação principal já usada.");

            if (personagem.Turno.MovimentoExecutado
                && acao == TipoAcao.Movimento)
                throw new Exception("Movimento já usado.");
        }

        public static void ExecutarAcao(Personagem personagem, TipoAcao acao)
        {
            if (acao == TipoAcao.Movimento)
                personagem.Turno.MovimentoExecutado = true;
            else
                personagem.Turno.AcaoExecutada = true;
        }

    }

    public class GerenciadorTurnos
    {
        private readonly Queue<Personagem> _ordem;

        public GerenciadorTurnos(IEnumerable<Personagem> personagens)
        {
            _ordem = new Queue<Personagem>(personagens.OrderByDescending(p => p.Iniciativa.Valor));
        }

        public Personagem Proximo()
        {
            var atual = _ordem.Dequeue();
            _ordem.Enqueue(atual);
            return atual;
        }
    }

    public static class FluxoTurnoService
    {
        public static void IniciarTurno(Personagem personagem)
        {
            personagem.Turno.AcaoExecutada = false;
            personagem.Turno.MovimentoExecutado = false;

            CondicaoService.ProcessarInicioTurno(personagem);
        }

        public static void FinalizarTurno(Personagem personagem)
        {
            // espaço para efeitos futuros
        }
    }


    //var atual = gerenciador.Proximo();

    //FluxoTurnoService.IniciarTurno(atual);

    //// exemplo: atacar
    //TurnoService.ValidarAcao(atual, TipoAcao.Ataque);

    //// resolve ataque aqui...

    //TurnoService.ExecutarAcao(atual, TipoAcao.Ataque);

    //FluxoTurnoService.FinalizarTurno(atual);



}
