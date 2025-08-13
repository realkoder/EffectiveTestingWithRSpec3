require_relative '../../../app/api'
require 'rack/test'

module ExpenseTracker
  RSpec.describe API do
    include Rack::Test::Methods

    def app
      API.new(ledger: ledger)
    end

    let(:ledger) { instance_double('ExpenseTracker::Ledger') }

    describe 'GET /expenses/:date' do
      context 'when expenses exist on the given date' do
        before do
          allow(ledger).to receive(:expenses_on).with('2017-06-10').and_return(['expense_1', 'expense_2'])
        end

        it 'returns the expense records as JSON' do
          get '/expenses/2017-06-10'

          parsed = JSON.parse(last_response.body)
          expect(parsed).to be_a(Array)
          expect(parsed.size).to be > 0
        end

        it 'responds with 200 (OK)' do
          get '/expenses/2017-06-10'
          expect(last_response.status).to eq(200)
        end
      end

      context 'when there are no expenses on the given date' do
        before do
          allow(ledger).to receive(:expenses_on).with('2017-06-10').and_return([])
        end

        it 'returns an empty array' do
          get '/expenses/2017-06-10'

          parsed = JSON.parse(last_response.body)
          expect(parsed).to be_a(Array)
          expect(parsed.size).to eq(0)
        end

        it 'responds with 200 (OK)' do
          get '/expenses/2017-06-10'
          expect(last_response.status).to eq(200)
        end
      end
    end

    describe 'POST /expenses' do
      def post_expenses
        post '/expenses', JSON.generate(expense), { 'CONTENT_TYPE' => 'application/json' }
        JSON.parse(last_response.body)
      end

      context 'when the expense is successfully recorded' do
        let(:expense) { { 'some' => 'data' } }

        before do
          allow(ledger).to receive(:record)
                             .with(expense)
                             .and_return(RecordResult.new(true, 417, nil))
        end

        it 'returns the expense id' do
          parsed = post_expenses

          expect(parsed).to include('expense_id' => 417)
        end

        it 'responds with 200 (OK)' do
          post_expenses
          expect(last_response.status).to eq(200)
        end
      end

      context 'when the expense fails validation' do
        let(:expense) { { 'some' => 'data' } }

        before do
          allow(ledger).to receive(:record)
                             .with(expense)
                             .and_return(RecordResult.new(false, 417, 'Expense incomplete'))
        end

        it 'returns an error message' do
          parsed = post_expenses
          expect(parsed).to include('error' => 'Expense incomplete')
        end

        it 'responds with 422 (Unprocessable entity' do
          post_expenses
          expect(last_response.status).to eq(422)
        end
      end
    end
  end
end