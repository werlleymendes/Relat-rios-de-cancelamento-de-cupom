SELECT a.nroempresa num_loja, a.nrocheckout pdv, b.motivo, e.nome operador, 
       c.nome autorizador, b.dtahoremissao, NVL(SUM(f.vlrtotal), 0) AS valor_total
       FROM consincomonitor.Tb_Logsegdoctopdv a 
         JOIN consincomonitor.tb_logsegurancapdv b 
              ON a.nroempresa = b.nroempresa AND
                 a.nrocheckout = b.nrocheckout AND
                 a.seqlogsegpdv = b.seqlogsegpdv
         JOIN consincomonitor.tb_usuario c
              ON b.sequsuario = c.sequsuario
         JOIN consincomonitor.TB_DOCTO d
              ON d.nroempresa = a.nroempresa and 
                 d.nrocheckout = a.nrocheckout and 
                 d.coo = a.coo and
                 d.serie = a.serie
         JOIN consincomonitor.tb_usuario e
              ON d.sequsuario = e.sequsuario
         LEFT OUTER JOIN consincomonitor.tb_doctoitem f
              ON d.nroempresa = f.nroempresa and
                 d.nrocheckout = f.nrocheckout and
                 d.seqdocto = f.seqdocto and 
                 f.status = 'V' and
                 trunc(f.dtahoremissao) between :DT1 and :DT2 
         WHERE a.dtamovimento between :DT1 and :DT2 and
               trunc(d.dtahorinclusao) between :DT1 and :DT2 and
               b.metodo IN ('mtCancelarCupom', 'mtCancelarCupomAnterior') and
               a.nroempresa = :LS1 and
               b.motivo is not null 
         GROUP BY a.nroempresa, a.nrocheckout, b.motivo, e.nome, c.nome, b.dtahoremissao;
