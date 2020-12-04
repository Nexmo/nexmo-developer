require 'spec_helper'

describe GreenhouseIo::Client do

  FAKE_API_TOKEN = '123FakeToken'

  it "should have a base url for an API endpoint" do
    expect(GreenhouseIo::Client.base_uri).to eq("https://harvest.greenhouse.io/v1")
  end

  context "given an instance of GreenhouseIo::Client" do

    before do
      GreenhouseIo.configuration.symbolize_keys = true
      @client = GreenhouseIo::Client.new(FAKE_API_TOKEN)
    end

    describe "#initialize" do
      it "has an api_token" do
        expect(@client.api_token).to eq(FAKE_API_TOKEN)
      end

      it "uses the configuration value when token is not specified" do
        GreenhouseIo.configuration.api_token = '123FakeENV'
        default_client = GreenhouseIo::Client.new
        expect(default_client.api_token).to eq('123FakeENV')
      end
    end

    describe "#path_id" do
      context "given an id" do
        it "returns an id path" do
          output = @client.send(:path_id, 1)
          expect(output).to eq('/1')
        end
      end

      context "given no id" do
        it "returns nothing" do
          output = @client.send(:path_id)
          expect(output).to be_nil
        end
      end
    end

    describe "#set_headers_info" do
      before do
        VCR.use_cassette('client/headers') do
          @client.candidates
        end
      end

      it "sets the rate limit" do
        expect(@client.rate_limit).to eq(20)
      end

      it "sets the remaining rate limit" do
        expect(@client.rate_limit_remaining).to eq(19)
      end

      it "sets rest link" do
        expect(@client.link).to eq('<https://harvest.greenhouse.io/v1/candidates/?page=1&per_page=100>; rel="last"')
      end
    end

    describe "#permitted_options" do
      let(:options) { GreenhouseIo::Client::PERMITTED_OPTIONS + [:where] }

      it "allows permitted options" do
        output = @client.send(:permitted_options, options)
        GreenhouseIo::Client::PERMITTED_OPTIONS.each do |option|
          expect(output).to include(option)
        end
      end

      it "discards non-permitted options" do
        output = @client.send(:permitted_options, options)
        expect(output).to_not include(:where)
      end
    end

    describe "#offices" do
      context "given no id" do
        before do
          VCR.use_cassette('client/offices') do
            @offices_response = @client.offices
          end
        end

        it "returns a response" do
          expect(@offices_response).to_not be_nil
        end

        it "returns an array of offices" do
          expect(@offices_response).to be_an_instance_of(Array)
        end

        it "returns office details" do
          expect(@offices_response.first).to have_key(:name)
        end
      end

      context "given an id" do
        before do
          VCR.use_cassette('client/office') do
            @office_response = @client.offices(220)
          end
        end

        it "returns a response" do
          expect(@office_response).to_not be_nil
        end

        it "returns an office hash" do
          expect(@office_response).to be_an_instance_of(Hash)
        end

        it "returns an office's details" do
          expect(@office_response).to have_key(:name)
        end
      end
    end

    describe "#departments" do
      context "given no id" do
        before do
          VCR.use_cassette('client/departments') do
            @departments_response = @client.departments
          end
        end

        it "returns a response" do
          expect(@departments_response).to_not be_nil
        end

        it "returns an array of departments" do
          expect(@departments_response).to be_an_instance_of(Array)
        end

        it "returns office details" do
          expect(@departments_response.first).to have_key(:name)
        end
      end

      context "given an id" do
        before do
          VCR.use_cassette('client/department') do
            @department_response = @client.departments(187)
          end
        end

        it "returns a response" do
          expect(@department_response).to_not be_nil
        end

        it "returns a department hash" do
          expect(@department_response).to be_an_instance_of(Hash)
        end

        it "returns a department's details" do
          expect(@department_response).to have_key(:name)
        end
      end
    end

    describe "#candidates" do
      context "given no id" do

        before do
          VCR.use_cassette('client/candidates') do
            @candidates_response = @client.candidates
          end
        end

        it "returns a response" do
          expect(@candidates_response).to_not be_nil
        end

        it "returns an array of candidates" do
          expect(@candidates_response).to be_an_instance_of(Array)
        end

        it "returns details of candidates" do
          expect(@candidates_response.first).to have_key(:first_name)
        end
      end

      context "given an id" do
        before do
          VCR.use_cassette('client/candidate') do
            @candidate_response = @client.candidates(1)
          end
        end

        it "returns a response" do
          expect(@candidate_response).to_not be_nil
        end

        it "returns a candidate hash" do
          expect(@candidate_response).to be_an_instance_of(Hash)
        end

        it "returns a candidate's details" do
          expect(@candidate_response).to have_key(:first_name)
        end
      end
    end

    describe "#activity_feed" do
      before do
        VCR.use_cassette('client/activity_feed') do
          @activity_feed = @client.activity_feed(1)
        end
      end

      it "returns a response" do
        expect(@activity_feed).to_not be_nil
      end

      it "returns an activity feed" do
        expect(@activity_feed).to be_an_instance_of(Hash)
      end

      it "returns details of the activity feed" do
        expect(@activity_feed).to have_key(:activities)
      end
    end

    describe "#create_candidate_note" do
      it "posts an note for a specified candidate" do
        VCR.use_cassette('client/create_candidate_note') do
          create_candidate_note = @client.create_candidate_note(
            1,
            {
                user_id: 2,
                message: "Candidate on vacation",
                visibility: "public"
            },
            2
          )
          expect(create_candidate_note).to_not be_nil
          expect(create_candidate_note).to include :body => 'Candidate on vacation'
        end
      end

      it "errors when given invalid On-Behalf-Of id" do
        VCR.use_cassette('client/create_candidate_note_invalid_on_behalf_of') do
          expect {
            @client.create_candidate_note(
              1,
              {
                  user_id: 2,
                  message: "Candidate on vacation",
                  visibility: "public"
              },
              99
            )
          }.to raise_error(GreenhouseIo::Error)
        end
      end

      it "errors when given an invalid candidate id" do
        VCR.use_cassette('client/create_candidate_note_invalid_candidate_id') do
          expect {
            @client.create_candidate_note(
              99,
              {
                  user_id: 2,
                  message: "Candidate on vacation",
                  visibility: "public"
              },
              2
            )
          }.to raise_error(GreenhouseIo::Error)
        end
      end

      it "errors when given an invalid user_id" do
        VCR.use_cassette('client/create_candidate_note_invalid_user_id') do
          expect {
            @client.create_candidate_note(
              1,
              {
                  user_id: 99,
                  message: "Candidate on vacation",
                  visibility: "public"
              },
              2
            )
          }.to raise_error(GreenhouseIo::Error)
        end
      end

      it "errors when missing required field" do
        VCR.use_cassette('client/create_candidate_note_invalid_missing_field') do
          expect {
            @client.create_candidate_note(
              1,
              {
                  user_id: 2,
                  visibility: "public"
              },
              2
            )
          }.to raise_error(GreenhouseIo::Error)
        end
      end
    end

    describe "#applications" do
      context "given no id" do
        before do
          VCR.use_cassette('client/applications') do
            @applications = @client.applications
          end
        end

        it "returns a response" do
          expect(@applications).to_not be_nil
        end

        it "returns an array of applications" do
          expect(@applications).to be_an_instance_of(Array)
        end

        it "returns application details" do
          expect(@applications.first).to have_key(:person_id)
        end
      end

      context "given an id" do
        before do
          VCR.use_cassette('client/application') do
            @application = @client.applications(1)
          end
        end

        it "returns a response" do
          expect(@application).to_not be_nil
        end

        it "returns an application hash" do
          expect(@application).to be_an_instance_of(Hash)
        end

        it "returns an application's details" do
          expect(@application).to have_key(:person_id)
        end
      end

      context "given a job_id" do
        before do
          VCR.use_cassette('client/application_by_job_id') do
            @applications = @client.applications(nil, :job_id => 144371)
          end
        end

        it "returns a response" do
          expect(@applications).to_not be_nil
        end

        it "returns an array of applications" do
          expect(@applications).to be_an_instance_of(Array)
          expect(@applications.first).to be_an_instance_of(Hash)
          expect(@applications.first).to have_key(:prospect)
        end
      end
    end

    describe "#scorecards" do
      before do
        VCR.use_cassette('client/scorecards') do
          @scorecard = @client.scorecards(1)
        end
      end

      it "returns a response" do
        expect(@scorecard).to_not be_nil
      end

      it "returns an array of scorecards" do
        expect(@scorecard).to be_an_instance_of(Array)
      end

      it "returns details of the scorecards" do
        expect(@scorecard.first).to have_key(:interview)
      end
    end

    describe "#all_scorecards" do
      before do
        VCR.use_cassette('client/all_scorecards') do
          @scorecard = @client.all_scorecards
        end
      end

      it "returns a response" do
        expect(@scorecard).to_not be_nil
      end

      it "returns an array of scorecards" do
        expect(@scorecard).to be_an_instance_of(Array)
      end

      it "returns details of the scorecards" do
        expect(@scorecard.first).to have_key(:interview)
      end
    end

    describe "#scheduled_interviews" do
      before do
        VCR.use_cassette('client/scheduled_interviews') do
          @scheduled_interviews = @client.scheduled_interviews(1)
        end
      end

      it "returns a response" do
        expect(@scheduled_interviews).to_not be_nil
      end

      it "returns an array of scheduled interviews" do
        expect(@scheduled_interviews).to be_an_instance_of(Array)
      end

      it "returns details of the interview" do
        expect(@scheduled_interviews.first).to have_key(:starts_at)
      end
    end

    describe "#jobs" do
      context "given no id" do
        before do
          VCR.use_cassette('client/jobs') do
            @jobs = @client.jobs
          end
        end

        it "returns a response" do
          expect(@jobs).to_not be_nil
        end

        it "returns an array of applications" do
          expect(@jobs).to be_an_instance_of(Array)
        end

        it "returns application details" do
          expect(@jobs.first).to have_key(:employment_type)
        end
      end

      context "given an id" do
        before do
          VCR.use_cassette('client/job') do
            @job = @client.jobs(4690)
          end
        end

        it "returns a response" do
          expect(@job).to_not be_nil
        end

        it "returns an application hash" do
          expect(@job).to be_an_instance_of(Hash)
        end

        it "returns an application's details" do
          expect(@job).to have_key(:employment_type)
        end
      end
    end

    describe "#stages" do
      before do
        VCR.use_cassette('client/stages') do
          @stages = @client.stages(4690)
        end
      end

      it "returns a response" do
        expect(@stages).to_not be_nil
      end

      it "returns an array of scheduled interviews" do
        expect(@stages).to be_an_instance_of(Array)
      end

      it "returns details of the interview" do
        expect(@stages.first).to have_key(:name)
      end
    end

    describe "#job_post" do
      before do
        VCR.use_cassette('client/job_post') do
          @job_post = @client.job_post(4690)
        end
      end

      it "returns a response" do
        expect(@job_post).to_not be_nil
      end

      it "returns an array of scheduled interviews" do
        expect(@job_post).to be_an_instance_of(Hash)
      end

      it "returns details of the interview" do
        expect(@job_post).to have_key(:title)
      end
    end

    describe "#users" do
      context "given no id" do
        before do
          VCR.use_cassette('client/users') do
            @users = @client.users
          end
        end

        it "returns a response" do
          expect(@users).to_not be_nil
        end

        it "returns an array of applications" do
          expect(@users).to be_an_instance_of(Array)
        end

        it "returns application details" do
          expect(@users.first).to have_key(:name)
        end
      end

      context "given an id" do
        before do
          VCR.use_cassette('client/user') do
            @job = @client.users(10327)
          end
        end

        it "returns a response" do
          expect(@job).to_not be_nil
        end

        it "returns an application hash" do
          expect(@job).to be_an_instance_of(Hash)
        end

        it "returns an application's details" do
          expect(@job).to have_key(:name)
        end
      end
    end

    describe "#sources" do
      context "given no id" do
        before do
          VCR.use_cassette('client/sources') do
            @sources = @client.sources
          end
        end

        it "returns a response" do
          expect(@sources).to_not be_nil
        end

        it "returns an array of applications" do
          expect(@sources).to be_an_instance_of(Array)
        end

        it "returns application details" do
          expect(@sources.first).to have_key(:name)
        end
      end

      context "given an id" do
        before do
          VCR.use_cassette('client/source') do
            @source = @client.sources(1)
          end
        end

        it "returns a response" do
          expect(@source).to_not be_nil
        end

        it "returns an application hash" do
          expect(@source).to be_an_instance_of(Hash)
        end

        it "returns an application's details" do
          expect(@source).to have_key(:name)
        end
      end
    end

    describe "#offers" do
      context "given no id" do
        before do
          VCR.use_cassette('client/offers') do
            @offers = @client.offers
          end
        end

        it "returns a response" do
          expect(@offers).to_not be nil
        end

        it "returns an array of offers" do
          expect(@offers).to be_an_instance_of(Array)
          expect(@offers.first[:id]).to be_a(Integer).and be > 0
          expect(@offers.first[:created_at]).to be_a(String)
          expect(@offers.first[:version]).to be_a(Integer).and be > 0
          expect(@offers.first[:status]).to be_a(String)
        end
      end

      context "given an id" do
        before do
          VCR.use_cassette('client/offer') do
            @offer = @client.offers(221598)
          end
        end

        it "returns a response" do
          expect(@offer).to_not be nil
        end

        it "returns an offer object" do
          expect(@offer).to be_an_instance_of(Hash)
          expect(@offer[:id]).to be_a(Integer).and be > 0
          expect(@offer[:created_at]).to be_a(String)
          expect(@offer[:version]).to be_a(Integer).and be > 0
          expect(@offer[:status]).to be_a(String)
        end
      end
    end

    describe "#offers_for_application" do
      before do
        VCR.use_cassette('client/offers_for_application') do
          @offers = @client.offers_for_application(123)
        end
      end

      it "returns a response" do
        expect(@offers).to_not be_nil
      end

      it "returns an array of offers" do
        expect(@offers).to be_an_instance_of(Array)

        return unless @offers.size > 0
        expect(@offers.first).to have_key(:application_id)
        expect(@offers.first).to have_key(:version)
        expect(@offers.first).to have_key(:status)
      end
    end

    describe "#current_offer_for_application" do
      before do
        VCR.use_cassette('client/current_offer_for_application') do
          @offer = @client.current_offer_for_application(123)
        end
      end

      it "returns a response" do
        expect(@offer).to_not be_nil
      end

      it "returns an offer object" do
        expect(@offer).to be_an_instance_of(Hash)
        expect(@offer[:id]).to be_a(Integer).and be > 0
        expect(@offer[:created_at]).to be_a(String)
        expect(@offer[:version]).to be_a(Integer).and be > 0
        expect(@offer[:status]).to be_a(String)
      end
    end
  end
end
