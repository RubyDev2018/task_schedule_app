require 'rails_helper'

describe TaskMailer, type: :mailer do

  let(:task) { FactoryBot.create(:task, name: 'メイラーSpecをかく', description: '送信したメール内容を確認')}

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8'}
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8'}
    part.body.raw_source
  end  

  describe '#creation_email' do
    let(:mail) { TaskMailer.creation_email(task) }

    it '想定通りのメールが生成' do
      # ヘッダ
      expect(mail.subject).to eq('タスク作成完了メール')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['taskleaf@example.com'])

      # text形式の本文
      expect(text_body).to match('以下のタスクを作成')
      expect(text_body).to match('メイラーSpecをかく')
      expect(text_body).to match('送信したメール内容を確認')

      # html形式の本文
      expect(html_body).to match('以下のタスクを作成')
      expect(html_body).to match('メイラーSpecをかく')
      expect(html_body).to match('送信したメール内容を確認')
    end
  end
end
