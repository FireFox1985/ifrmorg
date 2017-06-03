describe 'ToggleLanguage', js: true do
  let(:user) { create :user1 }

  feature 'Toggling the locale dropdown to change the language' do
    context 'When signed out' do
      before(:each) do
        visit root_path
      end

      after(:each) do
        page.execute_script('window.localStorage.clear()')
      end

      it 'language can be toggled on the same page' do
        within '#page_title' do
          expect(page).to have_content 'if me is a community for mental health experiences'
        end

        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'if me es una comunidad para compartir experiencias de salud mental'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'if me is a community for mental health experiences'
        end
      end

      it 'language can be toggled on different pages' do
        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'if me es una comunidad para compartir experiencias de salud mental'
        end

        click_link('Acerca de')
        within '#page_title' do
          expect(page).to have_content 'Acerca de'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'About'
        end
      end
    end

    context 'When signed out and then signed in' do
      before(:each) do
        visit root_path
      end

      after(:each) do
        logout(:user)
        page.execute_script('window.localStorage.clear()')
      end

      it 'language can be toggled on different pages' do
        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'if me es una comunidad para compartir experiencias de salud mental'
        end

        click_link('Acerca de')
        within '#page_title' do
          expect(page).to have_content 'Acerca de'
        end

        within '#header_content' do
          click_link('Ingresar')
        end

        within '#new_user' do
          fill_in('user_email', with: user.email)
          fill_in('user_password', with: user.password)
          click_button('Ingresar')
        end

        within '#page_title' do
          expect(page).to have_content '¡Adelante!'
        end

        within '.large-screen' do
          click_link('Momentos')
        end

        within '#page_title' do
          expect(page).to have_content 'Momentos'
        end
      end
    end

    context 'When signed in and then signed out' do
      before(:each) do
        login_as user
        visit root_path
      end

      after(:each) do
        logout(:user)
        page.execute_script('window.localStorage.clear()')
      end

      it 'language toggled when signed in persists when not signed in' do
        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content '¡Adelante!'
        end

        within '.large-screen' do
          click_link('Momentos')
        end

        within '#page_title' do
          expect(page).to have_content 'Momentos'
        end

        within '.large-screen' do
          click_link('Estrategias')
        end

        within '#page_title' do
          expect(page).to have_content 'Estrategias'
        end

        within '.large-screen' do
          page.find("#title_expand").click
        end

        within '#expand_me' do
          click_link('Cerrar sesión')
        end

        within '#page_title' do
          expect(page).to have_content 'if me es una comunidad para compartir experiencias de salud mental'
        end

        click_link('Contribuidores')
        within '#page_title' do
          expect(page).to have_content 'Contribuidores'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'Contributors'
        end

        click_link('Privacy Policy')
        within '#page_title' do
          expect(page).to have_content 'Privacy Policy'
        end
      end
    end

    context 'When signed in' do
      before(:each) do
        login_as user
        visit root_path
      end

      after(:each) do
        logout(:user)
        page.execute_script('window.localStorage.clear()')
      end

      it 'language can be toggled on the same page' do
        within '#page_title' do
          expect(page).to have_content 'Welcome'
        end

        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content '¡Adelante!'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'Welcome'
        end
      end

      it 'language can be toggle on different pages' do
        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content '¡Adelante!'
        end

        within '.large-screen' do
          click_link('Momentos')
        end

        within '#page_title' do
          expect(page).to have_content 'Momentos'
        end

        within '.large-screen' do
          click_link('Estrategias')
        end

        within '#page_title' do
          expect(page).to have_content 'Estrategias'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'Strategies'
        end

        within '.large-screen' do
          click_link('Medications')
        end

        within '#page_title' do
          expect(page).to have_content 'Medications'
        end
      end
    end
  end
end
