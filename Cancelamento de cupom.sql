SELECT * FROM consincomonitor.TB_DOCTOITEM A WHERE TRUNC(A.DTAHOREMISSAO) = '26-OCT-2025';

SELECT d.nroempresa, d.nrocheckout, d.coo, d.serie FROM consincomonitor.TB_DOCTO d where d.dtamovimento = trunc(sysdate)-1;

SELECT * FROM consincomonitor.Tb_Logsegdoctopdv a where a.dtamovimento = trunc(sysdate)-1;

SELECT * FROM consincomonitor.tb_logsegurancapdv a where trunc(a.dtahoremissao) = '28-oct-2025' 
and a.nroempresa = 4 and a.metodo IN ('mtCancelarCupom', 'mtCancelarCupomAnterior') and a.motivo is not null;



SELECT * FROM consincomonitor.vmon_cupomfiscal a where a.dtamovimento = '28-oct-2025'

SELECT table_name FROM all_all_tables a where a.owner = 'CONSINCOMONITOR' and a.table_name LIKE '%VENDA%';

SELECT * 
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
         WHERE a.dtamovimento = '28-oct-2025' and
               trunc(d.dtahorinclusao) = '28-oct-2025' and
               b.metodo IN ('mtCancelarCupom', 'mtCancelarCupomAnterior') and
               a.nroempresa = 4 and
               b.motivo is not null;
