# Fazl Xiter | Site + Painel Administrativo

## O que vem pronto
- Site público responsivo com cards e páginas individuais `/produto/slug`.
- Visual escuro, neon, gradientes, ícones PNG/GIF, status e data automática.
- Painel `/admin` para editar marca, fundo, produtos, botões, links, ordem, cores e arquivos.
- Botões de download direto via Supabase Storage (sem MediaFire).
- Demonstração local sem conta; para compartilhar mudanças e uploads, configure o Supabase.

## Testar sem pagar
1. Abra a pasta em um servidor local, por exemplo com `python -m http.server 8000`.
2. Visite `http://localhost:8000` e `/admin`. Sem Supabase, as mudanças só ficam no navegador usado.
3. Não abra o `index.html` via `file://`: use servidor HTTP.

## Publicar de verdade (gratuito dentro dos limites dos provedores)
1. Crie um projeto no https://supabase.com/ e uma conta de admin em **Authentication > Users > Add user**.
2. Em `supabase.sql`, substitua `SEU_EMAIL_AQUI` pelo email do usuário criado; execute todo o SQL em **SQL Editor**. Se precisar refazer a política, exclua a política antiga antes de executar novamente.
3. Copie **Project URL** e **anon/publishable key** em `config.js`. **Nunca use service_role/secret key no frontend.**
4. Faça upload de `index.html`, `style.css`, `app.js`, `config.js` no Cloudflare Pages (recomendado, porque suporta URLs amigáveis em apps de página única com fallback; configure um fallback para `index.html` se necessário).
5. Abra `/admin`, faça login e adicione produtos. Após salvar, mudanças aparecem para todos.
6. O armazenamento é público. **Não envie arquivos secretos ou privados.** Downloads são hospedados no Supabase Storage, sujeitos aos limites de tamanho, banda e uso do plano gratuito. Alguns navegadores podem abrir certos formatos em vez de baixá-los; para arquivos comuns como ZIP/APK o download normalmente é iniciado.

## Segurança e limitações
- Só usuários registrados na tabela `admins` podem alterar conteúdo ou enviar arquivos, segundo as políticas RLS.
- Não há cadastro público de admin nem senha embutida no site.
- Uploads do editor ainda não são removidos automaticamente quando se substitui um arquivo; remova arquivos antigos no painel do Supabase para economizar espaço.
- O site é uma aplicação estática; sem Supabase, não há sincronização entre aparelhos nem upload real.
- O plano gratuito tem cotas e pode mudar; arquivos grandes e muito tráfego podem exigir serviço pago.
- Para links externos, informe URLs HTTPS válidas.
- Ícones GIF animados são suportados como imagens, desde que não sejam bloqueados pelo navegador.
- A data muda quando o botão **Salvar e publicar produto** é usado; editar aparência global não muda a data de cada produto.
