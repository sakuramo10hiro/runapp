# ベースイメージ
FROM ruby:2.7.3
# Railsを使うために必要なコンポーネントを環境内にインストールする
RUN apt-get update -qq \
  && apt-get install -y nodejs yarn postgresql-client
# myappディレクトリを作成し、移動する
WORKDIR /runapp
# gemfileとgemfile.lockをコピーして既存アプリと同じgemをインストールする
COPY Gemfile /runapp/Gemfile
COPY Gemfile.lock /runapp/Gemfile.lock
RUN bundle install
# 既存アプリのコードをコンテナ内のmyappディレクトリ以下にコピーする
COPY . /runapp
# docker run時にserver.pidファイルを削除する設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# コンテナ起動時に公開することを想定されているポートを記述、あったほうが親切
EXPOSE 3000
# docker run時にrailsサーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]

RUN bundle config set --global force_ruby_platform true