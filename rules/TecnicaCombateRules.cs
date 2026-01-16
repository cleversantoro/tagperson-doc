using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TagPerson.Domain.ValueObjects;

namespace TagPerson.Domain.ValueObjects
{
    public enum MomentoTecnica
    {
        AntesDoAtaque,
        DepoisDoAtaque
    }

    public enum TipoEfeitoTecnica
    {
        BonusColuna,
        BonusDano,
        PenalidadeDefesa,
        Condicao
    }

    public class TecnicaCombate
    {
        public string Nome { get; init; }
        public GrupoArma Grupo { get; init; }
        public int NivelMinimo { get; init; }
        public int CustoEH { get; init; }
        public MomentoTecnica Momento { get; init; }
        public IReadOnlyList<EfeitoTecnica> Efeitos { get; init; }
    }

    public enum TipoDefesa
    {
        Esquiva,
        Aparar,
        Bloqueio
    }

    public class EfeitoTecnica
    {
        public TipoEfeitoTecnica Tipo { get; init; }
        public int Valor { get; init; }
        public string? Condicao { get; init; }
    }

    public static class TecnicaCombateService
    {
        public static void ValidarUso(TecnicaCombate tecnica, GrupoArmaPersonagem grupo, Personagem personagem)
        {
            if (grupo.Grupo != tecnica.Grupo)
                throw new Exception("Técnica incompatível com a arma.");

            if (grupo.Nivel < tecnica.NivelMinimo)
                throw new Exception("Nível insuficiente para usar a técnica.");

            if (personagem.EnergiaHeroica < tecnica.CustoEH)
                throw new Exception("Energia heroica insuficiente.");
        }

        public static void AplicarTecnica(TecnicaCombate tecnica, ref AtaqueContexto contexto, Personagem atacante, Personagem alvo)
        {
            atacante.EnergiaHeroica -= tecnica.CustoEH;

            foreach (var efeito in tecnica.Efeitos)
            {
                switch (efeito.Tipo)
                {
                    case TipoEfeitoTecnica.BonusColuna:
                        contexto.ModificadorColuna += efeito.Valor;
                        break;

                    case TipoEfeitoTecnica.BonusDano:
                        contexto.ModificadorDano += efeito.Valor;
                        break;

                    case TipoEfeitoTecnica.PenalidadeDefesa:
                        alvo.DefesaAtual += efeito.Valor;
                        break;

                    case TipoEfeitoTecnica.Condicao:
                        alvo.Condicoes.Add(efeito.Condicao!);
                        break;
                }
            }
        }

        public AtaqueResultado ExecutarAtaque(Personagem atacante, Personagem alvo, Arma arma, TecnicaCombate? tecnica)
        {
            var grupo = atacante.GruposArma
                .First(g => g.Grupo == arma.Grupo);

            var contexto = new AtaqueContexto();

            if (tecnica != null)
            {
                TecnicaCombateService.ValidarUso(tecnica, grupo, atacante);

                if (tecnica.Momento == MomentoTecnica.AntesDoAtaque)
                {
                    TecnicaCombateService.AplicarTecnica(tecnica, ref contexto, atacante, alvo);
                }
            }

            // cálculo normal do ataque aqui...

            if (tecnica?.Momento == MomentoTecnica.DepoisDoAtaque)
            {
                TecnicaCombateService.AplicarTecnica(tecnica, ref contexto, atacante, alvo);
            }

            return resultado;
        }
    }

    public class AtaqueContexto
    {
        public int ModificadorColuna { get; set; }
        public int ModificadorDano { get; set; }
    }

    public class DefesaPersonagem
    {
        public TipoDefesa Tipo { get; init; }
        public int ValorBase { get; init; }
    }

    public class Armadura
    {
        public string Nome { get; init; }
        public int Absorcao { get; init; }
        public int Penalidade { get; init; }
    }

    public static class ArmadurasSeed
    {
        public static IReadOnlyList<Armadura> Todas => new[]
        {
        new Armadura
        {
            Nome = "Couro",
            Absorcao = 3,
            Penalidade = 1
        },
        new Armadura
        {
            Nome = "Cota de Malha",
            Absorcao = 6,
            Penalidade = 3
        },
        new Armadura
        {
            Nome = "Placas",
            Absorcao = 9,
            Penalidade = 5
        }
        };
    }

    public static class DefesaService
    {
        public static int CalcularDefesaFinal(DefesaPersonagem defesa, Armadura? armadura)
        {
            if (defesa.Tipo == TipoDefesa.Esquiva && armadura != null)
                return defesa.ValorBase - armadura.Penalidade;

            return defesa.ValorBase;
        }

        public static void ValidarDefesa(int defesa)
        {
            if (defesa < 0)
                throw new Exception("Defesa inválida.");
        }


    }

    public static class DanoService
    {
        public static int CalcularDanoFinal(int danoBruto, Armadura? armadura)
        {
            var absorcao = armadura?.Absorcao ?? 0;
            var dano = danoBruto - absorcao;

            return dano < 0 ? 0 : dano;
        }
    }

    public class ResolverAtaqueUseCase
    {
        public ResultadoCombate Executar(Personagem atacante, Personagem defensor, Arma arma, TecnicaCombate? tecnica, int colunaAtaque, int rolagem)
        {
            // DEFESA
            var defesaBase = defensor.Defesa;
            var defesaFinal = DefesaService.CalcularDefesaFinal(defesaBase, defensor.Armadura);

            DefesaService.ValidarDefesa(defesaFinal);

            // ACERTO?
            if (rolagem > colunaAtaque - defesaFinal)
            {
                return ResultadoCombate.Erro();
            }

            // DANO BASE (exemplo simples)
            var danoBruto = colunaAtaque switch
            {
                <= 25 => arma.Dano25,
                <= 50 => arma.Dano50,
                <= 75 => arma.Dano75,
                _ => arma.Dano100
            };

            // DANO FINAL
            var danoFinal = DanoService.CalcularDanoFinal(danoBruto, defensor.Armadura);
            defensor.EnergiaFisica -= danoFinal;

            return ResultadoCombate.Acerto(danoFinal);
        }
    }

    public class ResultadoCombate
    {
        public bool Acertou { get; init; }
        public int Dano { get; init; }
        public static ResultadoCombate Erro() => new() { Acertou = false };
        public static ResultadoCombate Acerto(int dano) => new() { Acertou = true, Dano = dano };
    }

    public enum CondicaoCombate
    {
        Caido,
        Atordoado,
        Desarmado,
        Sangrando,
        Imobilizado,
        Surpreso
    }

    public class CondicaoAtiva
    {
        public CondicaoCombate Tipo { get; init; }
        public int DuracaoTurnos { get; set; } // -1 = permanente
        public List<CondicaoAtiva> Condicoes { get; } = new();
    }

    public class EfeitoCondicao
    {
        public int ModAtaque { get; init; }
        public int ModDefesa { get; init; }
        public bool ImpedeAtaque { get; init; }
        public bool ImpedeMovimento { get; init; }
        public int DanoPorTurno { get; init; }
    }

    public static class CondicoesTabela
    {
        public static EfeitoCondicao Obter(CondicaoCombate condicao) => condicao switch
        {
            CondicaoCombate.Caido => new EfeitoCondicao
            {
                ModAtaque = -3,
                ModDefesa = -5,
                ImpedeMovimento = true
            },

            CondicaoCombate.Atordoado => new EfeitoCondicao
            {
                ModAtaque = -5,
                ModDefesa = -5,
                ImpedeAtaque = true
            },

            CondicaoCombate.Desarmado => new EfeitoCondicao
            {
                ImpedeAtaque = true
            },

            CondicaoCombate.Sangrando => new EfeitoCondicao
            {
                DanoPorTurno = 2
            },

            CondicaoCombate.Imobilizado => new EfeitoCondicao
            {
                ImpedeMovimento = true,
                ImpedeAtaque = true
            },

            CondicaoCombate.Surpreso => new EfeitoCondicao
            {
                ModDefesa = -10
            },

            _ => new EfeitoCondicao()
        };
    }

    public static class CondicaoService
    {
        public static void Aplicar(Personagem alvo, CondicaoCombate condicao, int duracao)
        {
            if (alvo.Condicoes.Any(c => c.Tipo == condicao))
                return; // não acumula

            alvo.Condicoes.Add(new CondicaoAtiva
            {
                Tipo = condicao,
                DuracaoTurnos = duracao
            });

        }

        public static void ProcessarInicioTurno(Personagem personagem)
        {
            foreach (var condicao in personagem.Condicoes)
            {
                var efeito = CondicoesTabela.Obter(condicao.Tipo);

                if (efeito.DanoPorTurno > 0)
                    personagem.EnergiaFisica -= efeito.DanoPorTurno;

                if (condicao.DuracaoTurnos > 0)
                    condicao.DuracaoTurnos--;
            }

            personagem.Condicoes.RemoveAll(c => c.DuracaoTurnos == 0);
        }

        public static int CalcularModAtaque(Personagem personagem)
        {
            return personagem.Condicoes
                .Sum(c => CondicoesTabela.Obter(c.Tipo).ModAtaque);
        }

        public static int CalcularModDefesa(Personagem personagem)
        {
            return personagem.Condicoes
                .Sum(c => CondicoesTabela.Obter(c.Tipo).ModDefesa);
        }

        public static void ValidarPodeAtacar(Personagem personagem)
        {
            if (personagem.Condicoes.Any(c =>
                CondicoesTabela.Obter(c.Tipo).ImpedeAtaque))
                throw new Exception("Personagem não pode atacar.");
        }


    }

    //CondicaoService.ValidarPodeAtacar(atacante);

    //var modAtaque = CondicaoService.CalcularModAtaque(atacante);
    //var modDefesa = CondicaoService.CalcularModDefesa(defensor);

    //var colunaFinal = colunaBase + modAtaque;
    //var defesaFinal = defesaBase + modDefesa;


    //    new TecnicaCombate
    //{
    //    Nome = "Ataque Poderoso",
    //    Grupo = GrupoArma.CortePesadoMachados,
    //    NivelMinimo = 2,
    //    CustoEH = 2,
    //    Momento = MomentoTecnica.AntesDoAtaque,
    //    Efeitos = new[]
    //    {
    //        new EfeitoTecnica
    //        {
    //            Tipo = TipoEfeitoTecnica.BonusColuna,
    //            Valor = -2
    //        },
    //        new EfeitoTecnica
    //        {
    //            Tipo = TipoEfeitoTecnica.BonusDano,
    //            Valor = 5
    //        }
    //    }
    //};

    //    new TecnicaCombate
    //{
    //    Nome = "Quebrar Defesa",
    //    Grupo = GrupoArma.CorteMedioEspadas,
    //    NivelMinimo = 3,
    //    CustoEH = 3,
    //    Momento = MomentoTecnica.DepoisDoAtaque,
    //    Efeitos = new[]
    //    {
    //        new EfeitoTecnica
    //        {
    //            Tipo = TipoEfeitoTecnica.PenalidadeDefesa,
    //            Valor = -3
    //        }
    //    }
    //};

    //    new TecnicaCombate
    //{
    //    Nome = "Desarme",
    //    Grupo = GrupoArma.CombateImobilizacao,
    //    NivelMinimo = 2,
    //    CustoEH = 2,
    //    Momento = MomentoTecnica.DepoisDoAtaque,
    //    Efeitos = new[]
    //    {
    //        new EfeitoTecnica
    //        {
    //            Tipo = TipoEfeitoTecnica.Condicao,
    //            Condicao = "Desarmado"
    //        }
    //    }
    //};




}
