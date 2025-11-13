SELECT DISTINCT a.nroempresa num_loja, g.seqproduto, g.desccompleta, a.nrocheckout pdv, e.nome operador, 
       c.nome autorizador, b.dtahoremissao, f.vlrtotal
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
         JOIN consincomonitor.tb_doctoitem f
              ON d.nroempresa = f.nroempresa and
                 d.nrocheckout = f.nrocheckout and
                 d.seqdocto = f.seqdocto and                 
                 f.status = 'C' and
                 trunc(f.dtahoremissao) between :DT1 and :DT2
         JOIN consincomonitor.tb_produto g
              ON f.seqproduto = g.seqproduto
         WHERE a.dtamovimento between :DT1 and :DT2 and
               trunc(d.dtahorinclusao) between :DT1 and :DT2 and
               b.metodo = 'mtCancelarItem' and
               a.nroempresa = :LS1
         ORDER BY b.dtahoremissao;